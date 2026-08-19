library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
    Port ( 
        clk    : in  std_logic;
        reset  : in  std_logic;
        pc_in  : in  std_logic_vector(31 downto 0);
        pc_out : out std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of pc is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pc_out <= (others => '0');
        elsif rising_edge(clk) then
            pc_out <= pc_in;
        end if;
    end process;
end architecture;