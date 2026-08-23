library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_memory is
    Port (
        addr  : in  std_logic_vector(31 downto 0);
        instr : out std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of instruction_memory is

    constant MEM_SIZE_WORDS : integer := 16;

    type mem_array is array (0 to MEM_SIZE_WORDS-1) of std_logic_vector(31 downto 0);

    constant program : mem_array := (
        0  => x"00500293",  -- addi x5, x0, 5
        1  => x"00100313",  -- addi x6, x0, 1
        2  => x"0062afb3",  -- slt  x31, x5, x6
        others => x"00000013"  -- nop (addi x0, x0, 0)
    );

    signal word_index : integer range 0 to MEM_SIZE_WORDS;

begin

    word_index <= to_integer(unsigned(addr(31 downto 2)));

    instr <= program(word_index) when word_index < MEM_SIZE_WORDS else (others => '1');

end architecture;