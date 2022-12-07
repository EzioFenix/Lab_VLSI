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
		v_sync : OUT STD_LOGIC;
		selector: in std_logic_vector(1 downto 0)
		);
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
	generador_imagen: process(display_ena,row,column,selector)
begin
	if(display_ena ='1') then
		if((row>20 and row <30) and --p1 centro
			(column > 20 and column <30)) then
			red <= (others => '1');
			green <= (others => '1');
			blue <= (others => '1');
		elsif((row>0 and row <50) and --p1
			(column > 0 and column <50)) then
			red <= (others => '1');
			green <= (others => '0');
			blue <= (others => '0');
		elsif((row>20 and row <30) and --p2 cetro 
			(column > 609 and column <619)) then
			red <= (others => '1');
			green <= (others => '1');
			blue <= (others => '1');
		elsif ((row>0 and row <50) and --p2
				(column > 589 and column <639)) then
				red <= (others => '0');
				green <= (others => '1');
				blue <= (others => '0');
		elsif((row>449 and row <459) and --p3 centro
			(column > 609 and column <619)) then
			red <= (others => '1');
			green <= (others => '1');
			blue <= (others => '1');
		elsif ((row > 429 and row <479) and --p3
				(column >589 and column <639)) then
				red <= (others => '0');
				green <= (others => '0');
				blue <= (others => '1'); 
		elsif((row>449 and row <459) and --p4 centro
			(column > 20 and column <30)) then
			red <= (others => '1');
			green <= (others => '1');
			blue <= (others => '1');
		elsif ((row > 429 and row <479) and --p4
				(column > 0 and column <50)) then
				red <= (others => '0');
				green <= (others => '0');
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