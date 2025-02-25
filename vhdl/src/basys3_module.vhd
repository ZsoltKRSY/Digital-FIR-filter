----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2024 09:19:01 AM
-- Design Name: 
-- Module Name: Basys3_module - Behavioral
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

entity Basys3_module is
Port (  clk: in STD_LOGIC;
        sw: in STD_LOGIC_VECTOR(7 downto 0);
        btn: in STD_LOGIC_VECTOR(4 downto 0);
        led : out STD_LOGIC_VECTOR (15 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0);
        cat : out STD_LOGIC_VECTOR (6 downto 0)
        --outt: out STD_LOGIC_VECTOR(15 downto 0)
    );
end Basys3_module;

architecture Behavioral of Basys3_module is

component display_7seg is
    Port ( digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component filter_FIR is
    Generic( input_width : INTEGER;
             coeff_width : INTEGER;
             nr_of_coeffs : INTEGER;
             sampling_rate : INTEGER); --dat in Hz (maximul este 100MHz = 100.000.000Hz
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           input_data : in STD_LOGIC_VECTOR(input_width - 1 downto 0);
           output_data : out STD_LOGIC_VECTOR(input_width + coeff_width - 1 downto 0));
end component;

component debouncer is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           en : out STD_LOGIC);
end component;

signal input_data: std_logic_vector(7 downto 0);
signal output_data: std_logic_vector(15 downto 0);
signal rst_btn: std_logic := '0';
signal en_btn: std_logic := '0';

begin
    input_data <= sw(7 downto 0);
    --outt <= output_data;

    en: debouncer port map (
        clk => clk,
        btn => btn(0),
        en => en_btn
    );
    
    rst: debouncer port map (
        clk => clk,
        btn => btn(1),
        en => rst_btn
    );
    
    ssd: display_7seg port map (
        digit0=>output_data(3 downto 0),
        digit1=>output_data(7 downto 4),
        digit2=>output_data(11 downto 8),
        digit3=>output_data(15 downto 12),
        clk=>clk,
        cat=>cat,
        an=>an
    );
    
    filter: filter_FIR 
    generic map(
        input_width => 8,
        coeff_width => 8,
        nr_of_coeffs => 3,
        sampling_rate => 50 --nu conteaza valoarea, deocamdata folosim ceasul intern
    )
    port map(
        clk => clk,
        rst => rst_btn,
        en => en_btn,
        input_data => input_data,
        output_data => output_data
    );

end Behavioral;
