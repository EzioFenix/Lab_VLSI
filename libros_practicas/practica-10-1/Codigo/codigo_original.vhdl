-- Practica 10er


--------
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

--------

--------

--------

--------

--------