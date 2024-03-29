library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Std_logic_arith.all;
use IEEE.Std_logic_unsigned.all;

entity leds is
		Port( reloj: in std_logic;
				led1 : out std_logic;
				led2 : out std_logic;
				led3 : out std_logic;
				led4 : out std_logic;
				led5 : out std_logic;
				led6 : out std_logic;
				led7 : out std_logic;
				led8 : out std_logic);
end leds;

architecture behavioral of leds is

Component PWM is
		Port( reloj_pwm: in std_logic;
				D : in std_logic_vector (7 downto 0);
				S : out std_logic);
end component;

Component divisor is
		Generic (N : integer := 24);
		Port( reloj: in std_logic;
				div_reloj : out std_logic);
end component;

		signal relojPWM : std_logic;
		signal relojCiclo : std_logic;
		signal flag : std_logic := '0';
		signal a1: std_logic_vector(7 downto 0):=X"02";
		signal a2: std_logic_vector(7 downto 0):=X"04";
		signal a3: std_logic_vector(7 downto 0):=X"08";
		signal a4: std_logic_vector(7 downto 0):=X"10";
		signal a5: std_logic_vector(7 downto 0):=X"20";
		signal a6: std_logic_vector(7 downto 0):=X"40";
		signal a7: std_logic_vector(7 downto 0):=X"80";
		signal a8: std_logic_vector(7 downto 0):=X"FF";

		begin
				N1: divisor generic map (10) port map (reloj, relojPWM);
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
				if (relojCiclo'event) and (relojCiclo = '1') then
					if flag = '0' then
						a1 <= a8;
						a2 <= a1;
						a3 <= a2;
						a4 <= a3;
						a5 <= a4;
						a6 <= a5;
						a7 <= a6;
						a8 <= a7;
						if a8 = X"02" then
							flag <= '1';
							a8<=X"02";
							a7<=X"04";
							a6<=X"08";
							a5<=X"10";
							a4<=X"20";
							a3<=X"40";
							a2<=X"80";
							a1<=X"FF";
						end if;
					end if;
					if flag = '1' then 
						a1 <= a2;
						a2 <= a3;
						a3 <= a4;
						a4 <= a5;
						a5 <= a6;
						a6 <= a7;
						a7 <= a8;
						a8 <= a1;
						if a1 = X"02" then
							flag <= '0';
							a1<=X"02";
							a2<=X"04";
							a3<=X"08";
							a4<=X"10";
							a5<=X"20";
							a6<=X"40";
							a7<=X"80";
							a8<=X"FF";
						end if;
					end if;
				end if;
		end process;
end behavioral;