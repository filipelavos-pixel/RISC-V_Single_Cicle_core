library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    Port (
        a      : in  std_logic_vector(31 downto 0);
        b      : in  std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of adder is
    signal p : std_logic_vector(31 downto 0);
    signal g : std_logic_vector(31 downto 0);
    signal c : std_logic_vector(32 downto 0);
begin

    c(0) <= '0';

    gen_pg: for i in 0 to 31 generate
        p(i) <= a(i) xor b(i);
        g(i) <= a(i) and b(i);
    end generate gen_pg;

    gen_cla_blocks: for j in 0 to 7 generate
        c(j*4 + 1) <= g(j*4) or 
                      (p(j*4) and c(j*4));
                      
        c(j*4 + 2) <= g(j*4 + 1) or 
                      (p(j*4 + 1) and g(j*4)) or 
                      (p(j*4 + 1) and p(j*4) and c(j*4));
                      
        c(j*4 + 3) <= g(j*4 + 2) or 
                      (p(j*4 + 2) and g(j*4 + 1)) or 
                      (p(j*4 + 2) and p(j*4 + 1) and g(j*4)) or 
                      (p(j*4 + 2) and p(j*4 + 1) and p(j*4) and c(j*4));
                      
        c(j*4 + 4) <= g(j*4 + 3) or 
                      (p(j*4 + 3) and g(j*4 + 2)) or 
                      (p(j*4 + 3) and p(j*4 + 2) and g(j*4 + 1)) or 
                      (p(j*4 + 3) and p(j*4 + 2) and p(j*4 + 1) and g(j*4)) or 
                      (p(j*4 + 3) and p(j*4 + 2) and p(j*4 + 1) and p(j*4) and c(j*4));
    end generate gen_cla_blocks;

    gen_sum: for k in 0 to 31 generate
        result(k) <= p(k) xor c(k);
    end generate gen_sum;

end architecture;