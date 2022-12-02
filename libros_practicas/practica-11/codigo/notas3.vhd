When cero =>
if (i_row > 200 and i_row <210) and (i_col > 110 and i_col < 140) then -- A
o_red <= ( others => '1');
o_green <= ( others => '1');
o_blue <= ( others => '0');
elsif(i_row > 210 and i_row <240) and (i_col > 140 and i_col < 150) then -- B
o_red <= ( others => '0');
o_green <= ( others => '1');
o_blue <= ( others => '0');
elsif (i_row > 250 and i_row <280) and (i_col > 140 and i_col < 150) then -- C
o_red <= ( others => '1');
o_green <= ( others => '0');
o_blue <= ( others => '0');
elsif (i_row > 280 and i_row <290) and (i_col > 110 and i_col < 140) then -- D
o_red <= ( others => '1');
o_green <= ( others => '0');
o_blue <= ( others => '1');
elsif (i_row > 250 and i_row <280) and (i_col > 100 and i_col < 110) then -- E
o_red <= ( others => '0');
o_green <= ( others => '1');
o_blue <= ( others => '1');
elsif (i_row > 210 and i_row <240) and (i_col > 100 and i_col < 110) then -- F
o_red <= ( others => '1');
o_green <= ( others => '0');
o_blue <= ( others => '0');
else
o_red <= ( others => '1');
o_green <= ( others => '1');
o_blue <= ( others => '1');
end if;

i_row=row
i_column=column
o_red =red 
o_blue=blue 
o_green =green