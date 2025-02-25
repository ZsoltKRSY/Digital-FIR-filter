----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2024 06:30:59 PM
-- Design Name: 
-- Module Name: test_module_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_module_TB is
--  Port ( );
end test_module_TB;

architecture Behavioral of test_module_TB is

component test_module is
Port (
   clk : in STD_LOGIC;
   rst_btn : in STD_LOGIC;
   en_btn : in STD_LOGIC;
   input_data : in STD_LOGIC_VECTOR (15 downto 0);
   output_data : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

signal clk : STD_LOGIC := '0';
signal rst_btn : STD_LOGIC := '0';
signal en_btn : STD_LOGIC := '1';
signal input_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal output_data : STD_LOGIC_VECTOR(31 DOWNTO 0);

signal end_of_reading : std_logic := '0';

constant perioada: TIME := 20ns;

begin

    main_entity_TB: test_module port map( --coeficientii sunt a1=1, a2=2, a3=3
        clk => clk,
        rst_btn => rst_btn,
        en_btn => en_btn,
        input_data => input_data,
        output_data => output_data
    );

    clk <= not clk after perioada / 2;
    
    process (clk)
        file inputs : text open read_mode is "input_data.txt";
        variable in_line : line;
        
        variable read_data : std_logic_vector(15 downto 0);
        variable space : character;
    begin
        if rising_edge(clk) then
            if end_of_reading = '0' then
                if not endfile(inputs) then
                    readline(inputs, in_line);
                    read(in_line, read_data);
                    
                    input_data <= read_data;
                else
                    file_close(inputs);
                    end_of_reading <= '1';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
