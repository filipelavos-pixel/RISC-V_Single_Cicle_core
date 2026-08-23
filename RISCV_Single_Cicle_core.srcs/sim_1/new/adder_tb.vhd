library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_tb is
end entity;

architecture sim of adder_tb is

    signal a      : std_logic_vector(31 downto 0) := (others => '0');
    signal b      : std_logic_vector(31 downto 0) := (others => '0');
    signal result : std_logic_vector(31 downto 0);

begin

    uut: entity work.adder
        port map (
            a      => a,
            b      => b,
            result => result
        );

    stim_proc: process
    begin
        -- 0 + 0 = 0
        a <= x"00000000";
        b <= x"00000000";
        wait for 20 ns;

        -- 0 + 4 = 4
        a <= x"00000000";
        b <= x"00000004";
        wait for 20 ns;

        -- 8 + 4 = 12
        a <= x"00000008";
        b <= x"00000004";
        wait for 20 ns;

        -- carry across one 4-bit block
        -- 0x0000000F + 0x00000001 = 0x00000010
        a <= x"0000000F";
        b <= x"00000001";
        wait for 20 ns;

        -- carry across all 32 bits
        -- 0xFFFFFFFF + 0x00000001 = 0x00000000  (carry-out discarded due to overflow)
        a <= x"FFFFFFFF";
        b <= x"00000001";
        wait for 20 ns;

        -- 0xFFFFFFFF + 0xFFFFFFFF = 0xFFFFFFFE (carry-out discarded due to overflow)
        a <= x"FFFFFFFF";
        b <= x"FFFFFFFF";
        wait for 20 ns;

        -- generic sanity check
        -- 0x12345678 + 0x00000001 = 0x12345679
        a <= x"12345678";
        b <= x"00000001";
        wait for 20 ns;

        wait;
    end process;

end architecture;