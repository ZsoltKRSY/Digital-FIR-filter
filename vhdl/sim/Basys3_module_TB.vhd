----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2024 06:30:59 PM
-- Design Name: 
-- Module Name: Basys3_module_TB - Behavioral
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

entity Basys3_module_TB is
--  Port ( );
end Basys3_module_TB;

architecture Behavioral of Basys3_module_TB is

component Basys3_module is
Port (
    clk: in STD_LOGIC;
    sw: in STD_LOGIC_VECTOR(7 downto 0);
    btn: in STD_LOGIC_VECTOR(4 downto 0);
    led : out STD_LOGIC_VECTOR (15 downto 0);
    an : out STD_LOGIC_VECTOR (3 downto 0);
    cat : out STD_LOGIC_VECTOR (6 downto 0)
    --outt: out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

signal clk : STD_LOGIC := '0';
signal sw : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal btn : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
signal led : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal an : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal cat : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
--signal outt : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

signal end_of_reading : std_logic := '0';

constant perioada: TIME := 20ns;

begin
    btn(0) <= '1';

    Basys3_module_TB: Basys3_module port map( --coeficientii sunt a1=1, a2=2, a3=3
        clk => clk,
        sw => sw,
        btn => btn,
        led => led,
        an => an,
        cat => cat
        --outt => outt
    );

    clk <= not clk after perioada / 2;
    
    process (clk)
        file inputs : text open read_mode is "input_data_Basys3.txt";
        variable in_line : line;
        
        variable read_data : std_logic_vector(7 downto 0);
        variable space : character;
    begin
        if rising_edge(clk) then
            if end_of_reading = '0' then
                if not endfile(inputs) then
                    readline(inputs, in_line);
                    read(in_line, read_data);
                    
                    sw <= read_data;
                else
                    file_close(inputs);
                    end_of_reading <= '1';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
