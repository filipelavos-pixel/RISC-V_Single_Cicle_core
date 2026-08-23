library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_tb is
end entity;

architecture sim of pc_tb is

    constant CLOCK_PERIOD : time := 20 ns;

    signal clk    : std_logic := '0';
    signal reset  : std_logic := '0';
    signal pc_in  : std_logic_vector(31 downto 0) := (others => '0');
    signal pc_out : std_logic_vector(31 downto 0);

begin

    uut: entity work.pc
        port map (
            clk    => clk,
            reset  => reset,
            pc_in  => pc_in,
            pc_out => pc_out
        );

    clk_proc: process
    begin
        clk <= '0';
        wait for CLOCK_PERIOD/2;
        clk <= '1';
        wait for CLOCK_PERIOD/2;
    end process;

    stim_proc: process
    begin
        -- start with reset asserted: pc_out should go to 0 immediately (async reset)
        reset <= '1';
        pc_in <= x"AAAAAAAA";  -- deliberately wrong value, to prove reset overrides it
        wait for CLOCK_PERIOD;

        -- release reset, now pc_out should follow pc_in on each rising edge
        reset <= '0';
        pc_in <= x"00000004";
        wait for CLOCK_PERIOD;  -- after this rising edge, pc_out should be 4

        pc_in <= x"00000008";
        wait for CLOCK_PERIOD;  -- pc_out should be 8

        pc_in <= x"0000000C";
        wait for CLOCK_PERIOD;  -- pc_out should be 12

        -- assert reset again mid-run: pc_out should snap back to 0, even without a clock edge
        reset <= '1';
        wait for CLOCK_PERIOD/4;  -- deliberately NOT a full cycle, to test async behavior

        reset <= '0';
        pc_in <= x"00000010";
        wait for CLOCK_PERIOD;  -- pc_out should be 16

        wait;
    end process;

end architecture;