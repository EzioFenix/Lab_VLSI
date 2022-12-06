LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE IEEE.Std_logic_arith.ALL;
USE IEEE.Std_logic_unsigned.ALL;
ENTITY vga IS
	GENERIC (
		CONSTANT h_pulse : INTEGER := 96;
		CONSTANT h_bp : INTEGER := 48;
		CONSTANT h_pixels : INTEGER := 640;
		CONSTANT h_fp : INTEGER := 16;
		CONSTANT v_pulse : INTEGER := 2;
		CONSTANT v_bp : INTEGER := 33;
		CONSTANT v_pixels : INTEGER := 480;
		CONSTANT v_fp : INTEGER := 10);
	PORT (
		clk50Mhz : IN STD_LOGIC;
		clk25Mhz : inout STD_LOGIC;
		red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		h_sync : OUT STD_LOGIC;
		v_sync : OUT STD_LOGIC);
END ENTITY;
ARCHITECTURE behavioral OF vga IS
	CONSTANT h_period : INTEGER := h_pulse + h_bp + h_pixels + h_fp;
	CONSTANT v_period : INTEGER := v_pulse + v_bp + v_pixels + v_fp;
	SIGNAL h_count : INTEGER RANGE 0 TO h_period - 1 := 0;
	SIGNAL v_count : INTEGER RANGE 0 TO v_period - 1 := 0;
	SIGNAL reloj_pixel : STD_LOGIC;
	SIGNAL column : INTEGER := 0;
	SIGNAL row : INTEGER := 0;
	SIGNAL display_ena : STD_LOGIC;
BEGIN
	u1: entity work.Gen25MHz (behavior) port map (clk50Mhz,clk25Mhz);
	
	relojpixel : PROCESS (clk50MHz)
	BEGIN
		IF rising_edge(clk50MHz) THEN
			reloj_pixel <= NOT reloj_pixel;
		END IF;
	END PROCESS relojpixel;
	
	contadores : PROCESS (reloj_pixel)  --H_periodo = 800, V_periodo = 525
	BEGIN
		IF rising_edge(reloj_pixel) THEN
			IF (h_count < h_period - 1) THEN
				h_count <= h_count + 1;

			ELSE
				h_count <= 0;
				IF (v_count < v_period - 1) THEN
					v_count <= v_count + 1;
				ELSE
					v_count <= 0;
				END IF;
			END IF;
		END IF;
	END PROCESS contadores;
	senial_vsync : PROCESS (reloj_pixel) -- v_pixel + v_fp + v_pulse = 525
	BEGIN
		IF rising_edge(reloj_pixel) THEN

			IF (v_count >= v_pixels + v_fp) AND
				(v_count >= v_pixels + v_fp + v_pulse - 1) THEN

				v_sync <= '0';

			ELSE
				v_sync <= '1';
			END IF;
		END IF;
	END PROCESS senial_vsync;
	senial_hsync : PROCESS (reloj_pixel) -- h_pixels + h_fp + h_pulse = 784
	BEGIN
		IF rising_edge(reloj_pixel) THEN

			IF (h_count >= h_pixels + h_fp) AND
				(h_count >= h_pixels + h_fp + h_pulse - 1) THEN

				h_sync <= '0';

			ELSE
				h_sync <= '1';
			END IF;
		END IF;
	END PROCESS senial_hsync;
	coords_pixel : PROCESS (reloj_pixel) -- h_pixels + h_fp + h_pulse = 784
	BEGIN
		IF rising_edge(reloj_pixel) THEN
			IF (h_count < h_pixels) THEN
				column <= h_count;

			END IF;
			IF (v_count < v_pixels) THEN
				row <= v_count;
			END IF;
		END IF;
	END PROCESS coords_pixel;
	
-----
	generador_imagen: process(display_ena,row,column)
begin
	if(display_ena ='1') then
		if((0<row and row <60) and
			(column > 0 and column <639)) then
			red <= (others => '0');
			green <= (others => '0');
			blue <= (others => '0');
		elsif ((row > 61 and row <120) and
				(column > 0 and column <639)) then
				red <= (others => '0');
				green <= (others => '0');
				blue <= (others => '1');
		elsif ((row > 121 and row <180) and
				(column > 0 and column <639)) then
				red <= (others => '0');
				green <= (others => '1');
				blue <= (others => '1');
		elsif ((row > 181 and row <240) and
				(column > 0 and column <639)) then
				red <= (others => '1');
				green <= (others => '0');
				blue <= (others => '0');
		elsif ((row > 241 and row <300) and
				(column > 0 and column <639)) then
				red <= (others => '0');
				green <= (others => '1');
				blue <= (others => '0');
		elsif ((row > 301 and row <360) and
				(column > 0 and column <639)) then
				red <= (others => '1');
				green <= (others => '1');
				blue <= (others => '0');
		elsif ((row > 361 and row <420) and
				(column > 0 and column <639)) then
				red <= (others => '1');
				green <= (others => '0');
				blue <= (others => '1'); 
		elsif ((row > 421 and row <479) and
				(column > 0 and column <639)) then
				red <= (others => '1');
				green <= (others => '1');
				blue <= (others => '1');
		else
			red <= (others => '0');
			green <= (others => '0');
			blue  <= (others => '0');
		end if;
	else
		 red <= (others=> '0');
		 green <= (others => '0');
		 blue <= (others => '0');
	end if;
end process generador_imagen;
-----
	
	
	display_enable : PROCESS (reloj_pixel) -- h_pixels = 640 y v_pixels = 480
	BEGIN
		IF rising_edge(reloj_pixel) THEN

			IF (h_count < h_pixels AND v_count < v_pixels) THEN

				display_ena <= '1';

			ELSE
				display_ena <= '0';
			END IF;
		END IF;
	END PROCESS display_enable;
END ARCHITECTURE behavioral;