-----
/*	generador_imagen: process(display_ena,conectornum, i_row,i_col)
begin
	if(display_ena ='1') or (display_ena ='0') then
		case not(conectornum) is
		WHEN cero =>
		IF (i_row > 200 AND i_row < 210) AND (i_col > 110 AND i_col < 140) THEN -- A
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 210 AND i_row < 240) AND (i_col > 140 AND i_col < 150) THEN -- B
			o_red <= (OTHERS => '0');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 250 AND i_row < 280) AND (i_col > 140 AND i_col < 150) THEN -- C
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 280 AND i_row < 290) AND (i_col > 110 AND i_col < 140) THEN -- D
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '1');
		ELSIF (i_row > 250 AND i_row < 280) AND (i_col > 100 AND i_col < 110) THEN -- E
			o_red <= (OTHERS => '0');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '1');
		ELSIF (i_row > 210 AND i_row < 240) AND (i_col > 100 AND i_col < 110) THEN -- F
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '0');
		ELSE
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '1');
		END IF;
	when others =>
		IF (i_row > 200 AND i_row < 210) AND (i_col > 110 AND i_col < 140) THEN -- A
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 210 AND i_row < 240) AND (i_col > 140 AND i_col < 150) THEN -- B
			o_red <= (OTHERS => '0');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 250 AND i_row < 280) AND (i_col > 140 AND i_col < 150) THEN -- C
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 280 AND i_row < 290) AND (i_col > 110 AND i_col < 140) THEN -- D
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '1');
		ELSIF (i_row > 250 AND i_row < 280) AND (i_col > 100 AND i_col < 110) THEN -- E
			o_red <= (OTHERS => '0');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '1');
		ELSIF (i_row > 210 AND i_row < 240) AND (i_col > 100 AND i_col < 110) THEN -- F
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '0');
		ELSE
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '1');
		END IF;
	end case;
		
	else
		IF (i_row > 200 AND i_row < 210) AND (i_col > 110 AND i_col < 140) THEN -- A
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 210 AND i_row < 240) AND (i_col > 140 AND i_col < 150) THEN -- B
			o_red <= (OTHERS => '0');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 250 AND i_row < 280) AND (i_col > 140 AND i_col < 150) THEN -- C
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '0');
		ELSIF (i_row > 280 AND i_row < 290) AND (i_col > 110 AND i_col < 140) THEN -- D
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '1');
		ELSIF (i_row > 250 AND i_row < 280) AND (i_col > 100 AND i_col < 110) THEN -- E
			o_red <= (OTHERS => '0');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '1');
		ELSIF (i_row > 210 AND i_row < 240) AND (i_col > 100 AND i_col < 110) THEN -- F
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '0');
			o_blue <= (OTHERS => '0');
		ELSE
			o_red <= (OTHERS => '1');
			o_green <= (OTHERS => '1');
			o_blue <= (OTHERS => '1');
		END IF;
	end if;
end process generador_imagen;*/
-----