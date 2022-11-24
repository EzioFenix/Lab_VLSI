library ieee;
use ieee.std_logic_1164.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions

entity RX is
	port (
		reloj : in std_logic;
		leds: out std_logic_vector(7 downto 0);
		rx_wire : in std_logic
	);
end RX;

------
architecture behaivoral of RX is
	signal buff : std_logic_vector(9 downto 0);
	signal flag : std_logic :='0';
	signal pre: integer range 0 to 5208 :=0;
	signal indice : integer range 0 to 9 := 0;
	signal pre_val : integer range 0 to 41600;
	signal baud : std_logic_vector(2 downto 0);

------
begin
	RX_dato : process(reloj)
	begin
		if (reloj'event and reloj ='1') then
			if (flag='0' and rx_wire='0') then
				flag<='1';
				indice<=0;
				pre<=0;
			end if;
			if (flag='1') then
				buff(indice)<=rx_wire;
				if(pre < prev_val) then
					pre <=pre+1;
				else
					pre<=0;
				end if;
				if (pre= pre_val/2) then
					if (indice <9 ) then
						indice <= indice +1;
					else
						if (buff(0)='0' and buff(9)='1') then
							leds<= buff(8 downto 1);
						else
							leds <= "00000000";
						end if;
						flag <= '0';
					end if;
				end if;
			end if;
		end if;
	end process RX_dato;

------
baud<= "011";
with (baud) select
	pre_val <= 	41600 when "000", --1200 bauds
		20800 when "001", --2400 bauds
		10400 when "010", --4800 bauds
		5200 when "011", --9600 bauds
		2600 when "100", --19200 bauds
		1300 when "101", --38400 bauds
		866 when "110", --57600 bauds
		432 when others; --115200 bauds

end architecture behaivoral;