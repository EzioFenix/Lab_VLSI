Library IEEE;
Use IEEE.Std_logic_1164.all;
Use IEEE.Std_logic_arith.all;
Use IEEE.Std_logic_unsigned.all;

entity proyecto3 is
Port(
	reloj: in std_logic;
 	led1,led2,led3,led4,led5,led6,led7,led8 : out std_logic
	);
end proyecto3;


------------------------------------------------
architecture behavioral of proyecto3 is

	Component PWM is
	Port(
		relojpwm: in std_logic;
		D : in std_logic_vector (7 downto 0);
		S : out std_logic
		);
	end component;

	Component divisor is
	Generic (N : integer := 24);
	Port(
		reloj: in std_logic;
		div_reloj : out std_logic
		);
	end component;

	signal relojPWM : std_logic;
	signal relojCiclo : std_logic;
	signal a1: std_logic_vector(7 downto 0):= X"00";
	signal a2: std_logic_vector(7 downto 0):= X"1E";
	signal a3: std_logic_vector(7 downto 0):= X"3D";
	signal a4: std_logic_vector(7 downto 0):= X"5C";
	signal a5: std_logic_vector(7 downto 0):= X"7B";
	signal a6: std_logic_vector(7 downto 0):= X"9A";
	signal a7: std_logic_vector(7 downto 0):= X"A9";
	signal a8: std_logic_vector(7 downto 0):= X"FF";
	
begin
	N1: divisor generic map (10) port map (reloj, relojPWM);
	-- cada cuando cambia derecha a izquierda
	N2: divisor generic map (23) port map (reloj, relojCiclo); 
	P1: PWM port map (relojPWM, a1, led1);
	P2: PWM port map (relojPWM, a2, led2);
	P3: PWM port map (relojPWM, a3, led3);
	P4: PWM port map (relojPWM, a4, led4);
	P5: PWM port map (relojPWM, a5, led5);
	P6: PWM port map (relojPWM, a6, led6);
	P7: PWM port map (relojPWM, a7, led7);
	P8: PWM port map (relojPWM, a8, led8);
	
	process (relojCiclo)
			variable cuenta : integer range 0 to 255 := 0;
		begin
		if relojCiclo'event and relojCiclo = '1' then
			a1 <= a8;
			a2 <= a1;
			a3 <= a2;
			a4 <= a3;
			a5 <= a4;
			a6 <= a5;
			a7 <= a6;
			a8 <= a7;
		end if;
	end process;
end behavioral;