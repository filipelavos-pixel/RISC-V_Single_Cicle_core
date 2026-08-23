library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_memory_tb is
end entity;

architecture sim of instruction_memory_tb is

    signal addr  : std_logic_vector(31 downto 0) := (others => '0');
    signal instr : std_logic_vector(31 downto 0);

begin

    uut: entity work.instruction_memory
        port map (
            addr  => addr,
            instr => instr
        );

    stim_proc: process
    begin
        -- word 0: addi x5, x0, 5
        addr <= x"00000000";
        wait for 20 ns;

        -- word 1: addi x6, x0, 1
        addr <= x"00000004";
        wait for 20 ns;

        -- word 2: slt x31, x5, x6
        addr <= x"00000008";
        wait for 20 ns;

        -- word 3: should be nop
        addr <= x"0000000C";
        wait for 20 ns;

        -- last valid word (index 15)
        addr <= x"0000003C";
        wait for 20 ns;

        -- out of range (index 16 -> byte address 64 = 0x40), expect 0xFFFFFFFF
        addr <= x"00000040";
        wait for 20 ns;

        -- further out of range, still expect 0xFFFFFFFF
        addr <= x"00000100";
        wait for 20 ns;

        wait;
    end process;

end architecture;