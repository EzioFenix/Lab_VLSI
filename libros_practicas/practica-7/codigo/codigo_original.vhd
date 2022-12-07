-------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity sonicos is
	port (
			clk : in std_logic;
			sensor_disp: out std_logic;
			sensor_eco: in std_logic;
			anodos: out std_logic_vector(3 downto 0);
			segmentos: out std_logic_vector (7 downto 0)
		);
end sonicos;

architecture Behavioral of sonicos is
	signal cuenta: unsigned (16 downto 0):= (others => '0');
	signal centimentros: unsigned (15  downto 0) := (others=> '0');
	signal centimetros_unid: unsigned (3 downto 0):= (others=>'0');
	signal sal_unid: unsigned (3 downto 0) := (others => '0');
	signal sal_dece: unsigned (3 downto 0):= unsigned (3 downto 0):= (others => '0');
	signal digito: unsigned (3 downto 0):= (others=> '0');
	signal eco_pasado: std_logic :='0';
	signal eco_sinc : std_logic:='0';
	signal eco_nsinc: std_logic:='0';
	signal espera: std_logic='0';
	signal siete_seg_cuenta: unsigned(15 downto 0):= (others => '0');
	begin
		anodos(1 downto 0)<="11";

		siete_seg: process(clk)
		begin
			if rising_edge(clk) then
				if siete_seg_cuenta(siete_seg_cuenta'high)='1' then
					digito <= sal_unid;
					anodos (3 downto 2)<= "10";
				else
					digito <= sal_dece;
					anodos (3 downto 2) <= "10";
				end if;
				siete_seg_cuenta <= siete_seg_cuenta +1;
			end if;
		end process;

-------
trigger: process(clk)
begin
	if rising_edge (clk) then
		if espera='0' then
			if cuenta=500 then
				sensor_disp <='0';
				espera <='1';
				cuenta <= (others =>'0');
			else
				sensor_disp <='1';
				cuenta <= cuenta +1;
			end if;

-------
elsif eco_pasado ='0' and eco_sinc ='1' then
	cuenta <= (others => '0');
	centimentros <= (others => '0');
	centimetros_unid <= (others =>'0');
	centimentros_dece <= (others =>'0');
elsif eco_pasado ='1' and eco_sinc ='0' then
	sal_unid <= centimetros_unid;
	sal_dece <= centimentros_dece;
elsif cuenta = 2900-1 then
	if centimetros_unid= 9 then
		centimetros_unid <=(others =>'0');
		centimentros_dece <= centimentros_dece +1;
	else
		centimetros_unid <= centimetros_unid +1;
	end if;
	centimentros <= centimentros +1;
	cuenta <= (others =>'0');
	if centimentros =3448 then
		espera <='0';
	end if;
	else
		cuenta <= cuenta +1;
	end if;
		eco_pasado <= eco_sinc;
		eco_sinc <= eco_nsinc;
		eco_nsinc <= sensor_eco;

-------

-------

-------

-------

-------

-------

-------

-------

-------

-------

-------