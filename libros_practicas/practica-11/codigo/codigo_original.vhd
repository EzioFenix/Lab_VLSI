----- pag 70
port (
	clk50MHz: in std_logic; --al monitor
	red: out std_logic_vector (3 downto 0);
	blue : out std_logic_vector (3 downto 0);
	h_sync: out std_logic;
	v_sync : out std_logic;
	dipsw: in std_logic_vector(3 downto 0); -- numeros para
	A,B,C,D,E,F,G: out std_logic     --decodificador
	);
end entity mivga;

----- pag 71
constant cero: std_logic_vector(6 downto 0):="0111111";
constant uno: std_logic_vector(6 downto 0):="0000110";
constant dos: std_logic_vector(6 downto 0):="1011011";
constant tres: std_logic_vector(6 downto 0):="1001111";
constant cuatro: std_logic_vector(6 downto 0):="1100110";
constant cinco: std_logic_vector(6 downto 0):="1101101";
constant seis: std_logic_vector(6 downto 0):="1111101";
constant siete: std_logic_vector(6 downto 0):="0000111";
constant ocho: std_logic_vector(6 downto 0):="1111111";
constant nueve: std_logic_vector(6 downto 0):="1110011";
constant r1: std_logic_vector (3 downto 0):= (others => '1');
constant r0: std_logic_vector (3 downto 0):= (others => '0');
constant g1: std_logic_vector (3 downto 0):= (others => '1');
constant g0: std_logic_vector (3 downto 0):= (others => '0');
constant b1: std_logic_vector (3 downto 0):= (others => '1');
constant b0: std_logic_vector (3 downto 0):= (others => '0');
-- variable a,b,c,d,e,f,: std_logic;
signal conectornum: std_logic_vector(6 downto 0); --coneccion del 
												--decodificador con image_gen

----- pag 71
with dipsw select conectornum <= --decodificador para los nímeros
"0111111" when "0000",
"0000110" when "0001",
"1011011" when "0010",
"1001111" when "0011",
"1100110" when "0100",
"1101101" when "0101",
"1111101" when "0110",
"0000111" when "0111",
"1111111" when "1000",
"1110011" when "1001",
"0000000" when others;

----- pag 72

----- pag 73

----- pag 73

----- pag 74