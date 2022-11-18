-- 63

```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
	port(
		clk50mhz: in std_logic;
		red: out std_logic_vector (3 downto 0);
		green: out std_logic_vector (3 downto 0);
		blue: out std_logic_vector (3 downto 0);
		h_sync: out std_logic;
		v_sync: out std_logic
	);
end entity vga;
```

-- 64

```vhdl
relojpixe: process (clk50mhz) is
begin
	if rising_edge (clk50mhz) then
		reloj_pixel  <= not reloj_pixel;
	end if;
end process relojpixel; --25mhz
```

```vhdl
contadore: process (reloj_pixerl) -- H_periodo=800, V_periodo=525
begin
	if rising_edge(reloj_pixel) then
		if h_count <= (h_period-1) then
			h_count<= h_count +1;
		else
			h_count <=o;
			if v_count<(v_period-1) then
				v_count <= v_count +1;
			else
				v_count <=0;
			end if;
		end if;
	end if;
end process contadores;
```

--65

```vhdl
senial_hsync : process(reloj_pixel) -- h_pixel +h_fp + fp+h_pulse=784
begin
	if rising_edge (reloj_pixel) then
		if h_count > (h_pixels + h_fp) or
			h_count > (h_pixerls + h_fp + h_pulse) then
		h_sync <= '0';
        else
            h_sync <= '1';
       	end if;
	end if;
end process senial_hsync;

senial_vsync: process (reloj_pixel) -- vpixels+ v_fp+ v_pulse=525
	begin
		if rising_edge (reloj_pixel) then
			if V_count> (v_pixels + v_fp) or
				v_count >(v_pixels + v_fp + v_pulse) then
				v_sync<='1';
			end if;
		end if;
	end process senial_vsync;
	
coords_pixel: process(reloj_pixel)
begin  --- asignar una coordenada en parte visible
	if rising_edge (reloj_pixel) tthen
		if (h_count < h_pixels) then
			column<= h_count;
		end if;
		if (v_count< v_pixels) then
			row <= v_count;
		end if;
	end if;
end process coords_pixel;

```

--66

```vhdl
generador_imagen: process(display_ena,row,column)
begin
	if(display_ena ='1') then
		if((row>300 and row <350))
```

