---- 76
process(clk50mhz)
begin
	if (clk50mhz'event and (clk50mhz='1')) then
		conteo <= conteo +1;
		if (conteo=1)

---- 