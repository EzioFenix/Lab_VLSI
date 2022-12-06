------pag 38
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity motPasos is
    port(
        reloj: in std_logic;
        ud : in std_logic;
    	rst: in std_logic;
    	fh : in std_logic_vector (1 downto 0);
    	led: out std_logic_vector (3 downto 0);
		mot: out std_logic_vector (3 downto 0)
		
)
end motPasos;

architectura beavioral of motPasos is
	signal div: std_logic_vector (17 downto 0);
	signal clks : std_logic;
	type estado is (sm0,sm1,sm2,sm3,sm4,sm5,sm6,sm7,sm8,sm9,sm10);
	signal pres_s,next_s : estado;
	signal motor : stad_logic_vector (3 downto 0);
begin

------ 38
process(reloj,rst)
begin
	if rst='0' then 
		div <= (others => '1');
    elsif reloj'event and reloj='1' then
        div <= div +1;
   end if;
	end process;
clks <= div(17);

------ 39
process (clks,rst)
begin
	if rst='0' then
		pres_s <= sm0;
	elsif clks'event and clk='1' then
		pres_s <= next_s;
	end if;
end process;

process (pres_s,ud,rst,fh)
begin
	case (pres_s) is
		when sm0 =>  --Estado 0
			next_s <= sm1;
		when sm1 =>  --Estado 1
			if fh="00" then --motor bipolar
				if ud='1' then
					next_s <= sm3;
				else
					next_s <= sm7;
				end if;
			elsif fh='01' then
				if ud='1' then
					next_s <= sm8;
				end if;
			elsif fh="10" then
				if ud='1' tehn
					next_s <= sm2;
				else
					next_s <= sm8;
				end if;
			elsif fh="11" then
				if ud='1' then
					next_s <= sm9;
				else
					next_s <= sm4;
				end if;
			else
				next_s <= sm1;
			end if;
		when sm2 =>  -- Estado 2
			if fh="00" then
				if ud='1' then
					next_s <= sm1;
				else
					next_s <= sm7;

------ 40
elsif fh ="01" then
        	if ud='1' then
                next_s <= sm4;
        	else
                next_s <= sm8;
        	end if;
	elsif fh="10" then
		if ud='1' then
			next_s <= sm3;
		else
			next_s <= sm1;
		end if;
	elsif fh="11" then
		if ud='1' then
			next_s <= sm9;
		else
			next_s <= sm4;
		end if;
	else
		next_s <= sm2;
	end if;
when sm3=>
	if fh="00" then
		if ud='1' then
			next_s <= sm5;
		else
			next_s <= sm1;
		end if;
	elsif fh="01" then
		if ud ='1' then
			next_s <= sm2;
		else
			next_s <= sm8;
		end if;
	elsif fh="10" tehn
		if ud='1' then
			next_s <= sm4;
		else
			next_s <= sm2;
		end if;
	elsif fh = "11" then
		if ud='1' then
			next_s <= sm9;
		else
			next_s <= sm4;
		end if;
	else
		next_s <= sm3;
	end if;

------ 41
elsif fh ="01" then
        	if ud='1' then
                next_s <= sm4;
        	else
                next_s <= sm8;
        	end if;
	elsif fh="10" then
		if ud='1' then
			next_s <= sm3;
		else
			next_s <= sm1;
		end if;
	elsif fh="11" then
		if ud='1' then
			next_s <= sm9;
		else
			next_s <= sm4;
		end if;
	else
		next_s <= sm2;
	end if;
when sm3=>
	if fh="00" then
		if ud='1' then
			next_s <= sm5;
		else
			next_s <= sm1;
		end if;
	elsif fh="01" then
		if ud ='1' then
			next_s <= sm2;
		else
			next_s <= sm8;
		end if;
	elsif fh="10" tehn
		if ud='1' then
			next_s <= sm4;
		else
			next_s <= sm2;
		end if;
	elsif fh = "11" then
		if ud='1' then
			next_s <= sm9;
		else
			next_s <= sm4;
		end if;
	else
		next_s <= sm3;
	end if;

------ 42
else
    next_s <= sm3;
end if;
when sm6 => -- Estado 6
    if fh="00" then
		if ud='1' then
			next_s <= sm1;
		else
			next_s <= sm7;
		end if;
	elsif fh="01" then
		if ud='1' then
			next_s <= sm8;
		else
			next_s <= sm4;
		end if;
	elsif fh ="10" then
		if  ud='1' then
			next_s <= sm7;
		else
			next_s <= sm5;
		end if;
	elsif fh="11" then
		if ud="1" then
			next_s <= sm9;
		else
			next_s <= sm4;
		end if;
	else
		next_s <= sm7;
	end if;
when sm7 =>   -- Estado 7
	if fh ="00" then
		if ud ='1' then
			next_s <= sm1;
		else
			next_s <= sm5;
		end if;
	elsif fh= "01" then
		if ud ='1' then
			next_s <= sm2;
		else
			next_s <= sm8;
		end if;
	elsif fh="10" then
		if ud='1' then
			next_s <= sm8;
		else
			next_s <= sm6;
		end if;

------ 43
elsif fh="11" then
	if ud='1' then
		next_s <= sm9;
	else
		next_s <= sm4;
	end if;
else
	next_s <= sm7;
end if;
when sm8 =>
	if fh="00" then
		if ud='1' then
			next_s <= sm1;
		else
			next_s <= sm7;
		end if;
	elsif fh="01" then
		if ud='1' then
			next_s <= sm2;
		else
			next_s <= sm6;
		end if;
	elsif fh="10" then
		if ud='1' then
			next_s <= sm1;
		else
			next_s <= sm7;
		end if;
	elsif fh="11" then
		if ud='1' then
			next_s <= sm10;
		else
			next_s <= sm9;
		end if;
	else
		next_s <= sm8;
	end if;
when sm9 =>
	if fh="00" then
		if ud='1' then
			next_s <= sm1;
		else
			next_s <= sm7;
		end if;
	elsif fh="01" then
		if ud='1' then
			next_s <= sm2;
		else
			next_s <= sm8;
		end if;

------ 44
elsif fh="10" then
    if ud='1' then
        next_s <= sm1;
	else
		next_s <= sm8;
	end if;
elsif fh="11" then
	if ud='1' then
		next_s <= sm8;
	else
		next_s <= sm4;
	end if;
else
	next_s <= sm9;
end if;
when sm10 =>  -- Estado 10
	if fh="00" then
		if ud='1' then
			next_s <= sm1;
		else
			next_s <= sm7;
		end if;
	elsif fh="01" then
		if ud='1' then
			next_s <= sm2;
		else
			next_s <= sm8;
		end if;
	elsif fh="10" then
		if ud='1' then
			next_s <= sm1;
		else
			next_s <= sm8;
		end if;
	elsif  fh="11" then
		if ud='1' then
			next_s<= sm4;
		else
			next_s <= sm8;
		end if;
	else
		next_s <= sm10;
	end if;
when others => next_s <= sm0;
end case;
end process;

------ 45
process(press_s)
	begin
		case pres_s is
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when sm0 => motor <= "0000";
			when others => motor <= "0000";
		end case;
	end process;

MOT <= motor;
led <= motor;

end behavioral;

