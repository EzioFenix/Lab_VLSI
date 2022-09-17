Library IEEE;
Use IEEE.std_logic_1164.ALL;
Use IEEE.std_logic_arith.ALL;
Use IEEE.std_logic_unsigned.ALL;

Entity p2 is
	port( reloj, opcion:in std_logic;
			display1, display2, display3, display4, display5, display6: buffer std_logic_vector(6 downto 0));
End;

Architecture behavioral of p2 is
	signal segundo:std_logic;
	--Declaramos dos contadores de diferentes tamaños
	signal Q1: std_logic_vector(3 downto 0):="0000";
	signal Q2: std_logic_vector(5 downto 0):="000000";
	begin

	Divisor: process (reloj)
		variable cuenta : std_logic_vector (27 downto 0) := X"0000000";
		begin
		if rising_edge(reloj) then
			if cuenta = X"48009E0" then
				cuenta := X"0000000";
			else
				cuenta := cuenta + 1;
			End if;
		End if;
		segundo <= cuenta(22);
	End process;
	
	Contador: process (segundo,opcion)
		variable min,max: std_logic_vector(3 downto 0):="0000";
		begin
		if rising_edge(segundo) then
			if opcion='1' then
				Q2<=Q2+1;
			else
				Q1<=Q1+1;
			End if;
		End if;
	End process;
	
	Mensaje: process (opcion)
		begin
		
		if opcion='0' then
			case Q1 is		
			    when "0000"=>display1<="1000011"; 
				when "0001"=>display1<="1111001"; 
				when "0010"=>display1<="0000110"; 
				when "0011"=>display1<="0101011"; 
				when "0100"=>display1<="1100011"; 
				when "0101"=>display1<="0000110"; 
				when "0110"=>display1<="0101011"; 
				when "0111"=>display1<="1111001"; 
				when "1000"=>display1<="0100001"; 
				when "1001"=>display1<="0100011"; 
				when others  =>display1<="1111111"; 
			End case;
		else
			case Q2 is
				when "000000"=>display1<="0000110"; --C 
				when "000001"=>display1<="0100011"; --o 
				when "000010"=>display1<="0100111"; --c
				when "000011"=>display1<="0001000"; --A
				when "000100"=>display1<="0110111"; --= 
				when "000101"=>display1<="1111001"; --1 
				when "000110"=>display1<="1000000"; --0
				when "000111"=>display1<="1111111"; 
				when "001000"=>display1<="1111111"; 
				when "001001"=>display1<="0001000"; --A
				when "001010"=>display1<="0010000"; --G 
				when "001011"=>display1<="1100011"; --u 
				when "001100"=>display1<="0001000"; --A 
				when "001101"=>display1<="1111111"; 
				when "001110"=>display1<="1000110"; --C 
				when "001111"=>display1<="1001111"; --i 
				when "010000"=>display1<="0000110"; --E
				when "010001"=>display1<="1000111"; --L
				when "010010"=>display1<="0110111"; --=
				when "010011"=>display1<="1000000"; --0
				when "010100"=>display1<="0000000"; --8
				when "010101"=>display1<="1111111"; 
				when "010110"=>display1<="1111111"; 
				when "010111"=>display1<="1000110"; --C  
				when "011000"=>display1<="0001000"; --A 
				when "011001"=>display1<="0101011"; --n
				when "011010"=>display1<="0001000"; --A 
				when "011011"=>display1<="0100001"; --d
				when "011100"=>display1<="0001000"; --A
				when "011101"=>display1<="0100001"; --d 
				when "011110"=>display1<="0001000"; --A
				when "011111"=>display1<="1111111"; 
				when "100000"=>display1<="0100001"; --d
				when "100001"=>display1<="0101111"; --r
				when "100010"=>display1<="0010001"; --y
				when "100011"=>display1<="0110111"; --=
				when "100100"=>display1<="1111001"; --1 
				when "100101"=>display1<="0010010"; --5
				when "100110"=>display1<="0111111"; ---
				when "100111"=>display1<="0010010"; --5 
				when "101000"=>display1<="1000000"; --0 
				when "101001"=>display1<="1111111"; 
				when "101010"=>display1<="1111111"; 
				when "101011"=>display1<="0001100"; --P
				when "101100"=>display1<="0000110"; --E
				when "101101"=>display1<="0001100"; --P
				when "101110"=>display1<="0010010"; --5 
				when "101111"=>display1<="1001111"; --i 
				when "110000"=>display1<="0110111"; --=
				when "110001"=>display1<="1111001"; --1 
				when "110010"=>display1<="1000000"; --0
				when "110011"=>display1<="0111111"; --- 
				when "110100"=>display1<="0010010"; --5 
				when "110101"=>display1<="1000000"; --0 
				when others  =>display1<="1111111"; 
			End case;
		End if;
	End process;
	
	FF1: process(segundo)
		begin
		if rising_edge(segundo) then
			display2 <= display1;
		End if;
	End process;
	
	FF2: process(segundo)
		begin
		if rising_edge(segundo) then
			display3 <= display2;
		End if;
	End process;
	
	FF3: process(segundo)
		begin
		if rising_edge(segundo) then
			display4 <= display3;
		End if;
	End process;

	FF4: process(segundo)
		begin
		if rising_edge(segundo) then
			display5 <= display4;
		End if;
	End process;

	FF5: process(segundo)
		begin
		if rising_edge(segundo) then
			display6 <= display5;
		End if;
	End process;
 
End;