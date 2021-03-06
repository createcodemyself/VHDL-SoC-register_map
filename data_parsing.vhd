library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity data_parsing is
	port(
		nRst : in std_logic;
		clk : in std_logic;
		in_data : in std_logic_vector(7 downto 0);
		valid : in std_logic;
		write_s : out std_logic;
		read_s : out std_logic;
		address : out std_logic_vector( 7 downto 0);
		data : out std_logic_vector( 7 downto 0)
	);
end data_parsing;

architecture BEH of data_parsing is
	function data_decode(in_data : std_logic_vector(7 downto 0)) return
				std_logic_vector is
				variable return_data : std_logic_vector( 3 downto 0);
	begin
		case in_data is	
			when "00110000" => return_data := "0000";
			when "00110001" => return_data := "0001";
			when "00110010" => return_data := "0010";
			when "00110011" => return_data := "0011";
			when "00110100" => return_data := "0100";
			when "00110101" => return_data := "0101";
			when "00110110" => return_data := "0110";
			when "00110111" => return_data := "0111";
			when "00111000" => return_data := "1000";
			when "00111001" => return_data := "1001";
			when "01100001" => return_data := "1010"; -- a
			when "01100010" => return_data := "1011"; -- b
			when "01100011" => return_data := "1100"; -- c
			when "01100100" => return_data := "1101"; -- d
			when "01100101" => return_data := "1110"; -- e
			when "01100110" => return_data := "1111"; -- f
			when "01000001" => return_data := "1010"; -- A
			when "01000010" => return_data := "1011"; -- B	
			when "01000011" => return_data := "1100"; -- C
			when "01000100" => return_data := "1101"; -- D
			when "01000101" => return_data := "1110"; -- E
			when "01000110" => return_data := "1111"; -- F
			when others => return_data := "0000";
		end case;
	return(return_data);
end data_decode;

signal temp_data : std_logic_vector(7 downto 0);
signal data_0 : std_logic_vector(7 downto 0);
signal data_1 : std_logic_vector(7 downto 0);
signal data_2 : std_logic_vector(7 downto 0);
signal data_3 : std_logic_vector(7 downto 0);
signal data_4 : std_logic_vector(7 downto 0);
signal data_5 : std_logic_vector(7 downto 0);
signal data_6 : std_logic_vector(7 downto 0);
signal data_7 : std_logic_vector(7 downto 0);
signal data_8 : std_logic_vector(7 downto 0);
signal data_9 : std_logic_vector(7 downto 0);
signal data_10 : std_logic_vector(7 downto 0);
signal data_11 : std_logic_vector(7 downto 0);
signal valid_d : std_logic;
signal valid_det : std_logic;
signal valid_det_d : std_logic;
signal valid_det_d2 : std_logic;

begin
	process(nRst, clk)
	begin
		if(nRst = '0') then
			valid_d <= '0';
			valid_det <= '0';
			valid_det_d <= '0';
			valid_det_d2 <= '0';
		elsif rising_edge(clk) then
			valid_d <= valid;
			valid_det_d <= valid_det;
			valid_det_d2 <= valid_det_d;
			if(valid_d = '0') and (valid = '1') then
				valid_det <= '1';
			else
				valid_det <= '0';
			end if;
		end if;
	end process;
	
	process(nRst, clk)
	begin
		if(nRst = '0') then
			temp_data <= (others => '0');
			data_0 <= (others => '0');
			data_1 <= (others => '0');
			data_2 <= (others => '0');
			data_3 <= (others => '0');
			data_4 <= (others => '0');
			data_5 <= (others => '0');
			data_6 <= (others => '0');
			data_7 <= (others => '0');
			data_8 <= (others => '0');
			data_9 <= (others => '0');
			data_10 <= (others => '0');
			data_11 <= (others => '0');
			address <= (others => '0');
			data <= (others => '0');
			write_s <= '0';
			read_s <= '0';
		elsif rising_edge(clk) then
			temp_data <= in_data;
			if(valid_det = '1') then
				data_0 <= temp_data;
				data_1 <= data_0;
				data_2 <= data_1;
				data_3 <= data_2;
				data_4 <= data_3;
				data_5 <= data_4;
				data_6 <= data_5;
				data_7 <= data_6;
				data_8 <= data_7;
				data_9 <= data_8;
				data_10 <= data_9;
				data_11 <= data_10;
			end if;
			
			if(data_0 = x"0D") then
				if(( data_11 = x"77") and (data_10 = x"20") and (data_9 = x"30") and (data_8 = x"78") and (data_5 = x"20") and (data_4 = x"30") and (data_3 = x"78")) then
					write_s <= valid_det_d2;
					address <= data_decode(data_7) & data_decode(data_6);
					data <= data_decode(data_2) & data_decode(data_1);
				end if;
			if ((data_6 = x"72") and(data_5 = x"20") and (data_4 = x"30") and (data_3 = x"78")) then
				read_s <= valid_det_d2;
				address <= data_decode(data_2) & data_decode(data_1);
				data <= (others => '0');
			end if;
		end if;
	end if;
	end process;
end BEH;
		