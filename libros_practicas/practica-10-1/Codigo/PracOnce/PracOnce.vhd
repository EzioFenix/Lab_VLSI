LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE IEEE.Std_logic_arith.ALL;
USE IEEE.Std_logic_unsigned.ALL;



Entity PracOnce is

GENERIC (
		CONSTANT h_pulse : INTEGER := 96;
		CONSTANT h_bp : INTEGER := 48;
		CONSTANT h_pixels : INTEGER := 640;
		CONSTANT h_fp : INTEGER := 16;
		CONSTANT v_pulse : INTEGER := 2;
		CONSTANT v_bp : INTEGER := 33;
		CONSTANT v_pixels : INTEGER := 480;
		CONSTANT v_fp : INTEGER := 10);



port(clk50Mhz: in std_logic;
		clk25Mhz : inout STD_LOGIC;
		red: out std_logic_vector(3 downto 0);
		green: out std_logic_vector(3 downto 0);
		blue : out std_logic_vector(3 downto 0);
		h_sync: out std_logic;
		v_sync : out std_logic;
		dipsw : in std_logic_vector (3 downto 0);
		A, B, C, D, E , F, G : out std_logic);
End Entity;

ARCHITECTURE behavioral OF PracOnce IS
	CONSTANT h_period : INTEGER := h_pulse + h_bp + h_pixels + h_fp;
	CONSTANT v_period : INTEGER := v_pulse + v_bp + v_pixels + v_fp;
	SIGNAL h_count : INTEGER RANGE 0 TO h_period - 1 := 0;
	SIGNAL v_count : INTEGER RANGE 0 TO v_period - 1 := 0;
	SIGNAL reloj_pixel : STD_LOGIC;
	SIGNAL i_col : INTEGER := 0;
	SIGNAL i_row : INTEGER := 0;
	SIGNAL display_ena : STD_LOGIC;
	signal conectornum: std_logic_vector (6 downto 0) := "0000000";
	
constant cero: std_logic_vector (6 downto 0) := "0111111";
constant uno: std_logic_vector (6 downto 0) := "0000110";
constant dos: std_logic_vector (6 downto 0) := "1011011";
constant tres: std_logic_vector (6 downto 0) := "1001111";
constant cuatro: std_logic_vector (6 downto 0) := "1100110";
constant cinco: std_logic_vector (6 downto 0) := "1101101";
constant seis: std_logic_vector (6 downto 0) := "1111101";
constant siete: std_logic_vector (6 downto 0) := "0000111";
constant ocho: std_logic_vector (6 downto 0) := "1111111";
constant nueve: std_logic_vector (6 downto 0) := "1110011";
constant r1: std_logic_vector (3 downto 0) := (others => '1');
constant r0: std_logic_vector (3 downto 0) := (others => '0');
constant g1: std_logic_vector (3 downto 0) := (others => '1');
constant g0: std_logic_vector (3 downto 0) := (others => '0');
constant b1: std_logic_vector (3 downto 0) := (others => '1');
constant b0: std_logic_vector (3 downto 0) := (others => '0');	
	
	
	
	
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
				i_col <= h_count;

			END IF;
			IF (v_count < v_pixels) THEN
				i_row <= v_count;
			END IF;
		END IF;
	END PROCESS coords_pixel;	




with dipsw select conectornum <=
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
		
generador_imagen: process(display_ena,conectornum,i_row,i_col)
begin		
	if(display_ena ='1') then	
case conectornum is
			When cero =>
			if (i_row > 0 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			elsif (i_row > 250 and i_row <280) and (i_col > 100 and i_col < 110) then -- E
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '1');
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			else
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '1');
			end if;
			
			When uno =>
			if ((i_row > 210 and i_row < 240 ) and(i_col > 140 and i_col < 150 )) then
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif
			((i_row > 250 and i_row < 280 ) and (i_col > 140 and i_col < 150 )) then
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			End If;
			
			When dos =>
			if ((i_row > 200 and i_row < 210 ) and (i_col > 110 and i_col < 140 )) then
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '1');
			elsif
			((i_row > 210 and i_row < 240 ) and (i_col > 140 and i_col < 150 )) then
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif
			((i_row > 280 and i_row < 290 ) and(i_col > 110 and i_col < 140 )) then
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '1');
			elsif
			((i_row > 250 and i_row < 280 ) and (i_col > 100 and i_col < 110 )) then
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '1');
			elsif
			((i_row > 240 and i_row < 250 ) and (i_col > 110 and i_col < 140 )) then
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			else
				red <= (others => '0');
				green <= (others => '0');
				blue <= (others => '0');
			End If;
			
			When tres =>
			if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			End if;	
			
			When cuatro =>
			
			if(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			end if;	
			
			when cinco =>
			
			if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			end if;	
				
			when seis =>
			
			if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
				
				
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			elsif (i_row > 250 and i_row <280) and (i_col > 100 and i_col < 110) then -- E
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '1');	
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			
		END IF;	
				
				
			when siete =>
			
			if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
			
			elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			end if;	
			
			when ocho =>
			
			if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
				
			elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');	
				
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			elsif (i_row > 250 and i_row <280) and (i_col > 100 and i_col < 110) then -- E
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '1');	
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
			
		end if;	
				
			when nueve =>
		
		if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '1');
				green <= ( others => '1');
				blue <= ( others => '0');
				
			elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '1');
				blue <= ( others => '0');	
				
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '1');
				green <= ( others => '0');
				blue <= ( others => '1');
				
			end if;	
			
			when others => 
			
			if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');
				
			elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');	
				
			elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');
				
			elsif (i_row > 250 and i_row <280) and (i_col > 100 and i_col < 110) then -- E
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');	
			elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');
			elsif (i_row > 240 and i_row <250) and (i_col > 110 and i_col < 140) then -- G
				red <= ( others => '0');
				green <= ( others => '0');
				blue <= ( others => '0');
			
			end if;
			
				
		end case;
		
end if;		
	end process;
	
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
				
				