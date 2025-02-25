----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2024 12:22:35 PM
-- Design Name: 
-- Module Name: test_module - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_module is
    Port ( clk : in STD_LOGIC;
           rst_btn : in STD_LOGIC;
           en_btn : in STD_LOGIC;
           input_data : in STD_LOGIC_VECTOR (15 downto 0);
           output_data : out STD_LOGIC_VECTOR (31 downto 0));
end test_module;

architecture Behavioral of test_module is

component filter_FIR is
    Generic( input_width : INTEGER;
             coeff_width : INTEGER;
             nr_of_coeffs : INTEGER;
             sampling_rate : INTEGER --dat in Hz (maximul este 100MHz = 100.000.000Hz
         );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           input_data : in STD_LOGIC_VECTOR (input_width - 1 downto 0);
           output_data : out STD_LOGIC_VECTOR (input_width + coeff_width - 1 downto 0)
           );
end component;

begin

filter: filter_FIR
    generic map(
        input_width => 16,
        coeff_width => 16,
        nr_of_coeffs => 3,
        sampling_rate => 50 --nu conteaza valoarea, pentru testbench folosim clk-ul intern fara divizare
    )
    port map(
        clk => clk,
        rst => rst_btn,
        en => en_btn,
        input_data => input_data,
        output_data => output_data
    );


end Behavioral;
