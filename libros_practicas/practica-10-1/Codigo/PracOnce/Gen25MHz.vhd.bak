Library IEEE;
Use IEEE.Std_logic_1164.all;

Entity Gen25MHz is
port (clk50MHz: in std_logic;
	clk25MHz: inout std_logic:='0');
End Entity;

Architecture behavior of Gen25MHZ is
Begin
	Process(clk50MHz)
	Begin
		if clk50MHz'event and clk50MHz='1' then
		clk25MHz <= not clk25MHz;
	End if;
End Process;
End behavior;

