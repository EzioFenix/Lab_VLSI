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
		o_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		o_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		o_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		h_sync : OUT STD_LOGIC;
		v_sync : OUT STD_LOGIC;
		dipsw: in std_logic_vector(3 downto 0); -- numeros para
		A,B,C,D,E,F,G: out std_logic     --decodificador
		);
END ENTITY;
ARCHITECTURE behavioral OF vga IS
	CONSTANT h_period : INTEGER := h_pulse + h_bp + h_pixels + h_fp;
	CONSTANT v_period : INTEGER := v_pulse + v_bp + v_pixels + v_fp;
	----nuevo
	constant cero: std_logic_vector(6 downto 0):="0111111";
constant uno: std_logic_vector(6 downto 0):="0000110";
constant dos: std_logic_vector(6 downto 0):="1011011";
constant tres: std_logic_vector(6 downto 0):="1001111";
constant cuatro: std_logic_vector(6 downto 0):="1100110";
constant cinco: std_logic_vector(6 downto 0):="1101101";
constant seis: std_logic_vector(6 downto 0):="1111101";
constant siete: std_logic_vector(6 downto 0):="0000111";
constant ocho: std_logic_vector(6 downto 0):="1111111";
constant nueve: std_logic_vector(6 downto 0):="1110011";
constant r1: std_logic_vector (3 downto 0):= (others => '1');
constant r0: std_logic_vector (3 downto 0):= (others => '0');
constant g1: std_logic_vector (3 downto 0):= (others => '1');
constant g0: std_logic_vector (3 downto 0):= (others => '0');
constant b1: std_logic_vector (3 downto 0):= (others => '1');
constant b0: std_logic_vector (3 downto 0):= (others => '0');
signal conectornum: std_logic_vector(6 downto 0); --coneccion del 
	---nuevo
	
	
	SIGNAL h_count : INTEGER RANGE 0 TO h_period - 1 := 0;
	SIGNAL v_count : INTEGER RANGE 0 TO v_period - 1 := 0;
	SIGNAL reloj_pixel : STD_LOGIC;
	SIGNAL column : INTEGER := 0;
	SIGNAL row : INTEGER := 0;
	SIGNAL display_ena : STD_LOGIC;
BEGIN
	--u1: entity work.Gen25MHz (behavior) port map (clk50Mhz,clk25Mhz); --no usado
	
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
				row <= h_count;

			END IF;
			IF (v_count < v_pixels) THEN
				row <= v_count;
			END IF;
		END IF;
	END PROCESS coords_pixel;
	
generador_imagen: process(display_ena,row,column)
begin
	if(display_ena ='1') then
		if((row>300 and row <350) and
			(column > 350 and column <4000)) then
			o_red <= (others => '1');
			o_green <= (others => '0');
			o_blue <= (others => '0');
		elsif ((row > 300 and row <350) and
				(column > 450 and column <500)) then
				o_red <= (others => '0');
				o_green <= (others => '1');
				o_blue <= (others => '0');
		elsif ((row > 300 and row <350) and
				(column >550 and column <600)) then
				o_red <= (others => '0');
				o_green <= (others => '0');
				o_blue <= (others => '1'); 
		else
			o_red <= (others => '0');
			o_green <= (others => '0');
			o_blue  <= (others => '0');
		end if;
	else
		 o_red <= (others=> '0');
		 o_green <= (others => '0');
		 o_blue <= (others => '0');
	end if;
end process generador_imagen;
	

	
	
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
	
	---neuvo
	with dipsw select conectornum <= --decodificador para los nímeros
"0111111" when "0000",
"0000110" when "0001",
"1011011" when "0010",
"1001111" when "0011",
"1100110" when "0100",
"1101101" when "0101",
"1111101" when "0110",
"0000111" when "0111",
"1111111" when "1000",
"1110011" when "1001",
"0000000" when others;
	
END ARCHITECTURE behavioral;