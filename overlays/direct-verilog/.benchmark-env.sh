# Direct-Verilog-lane VerilogEval benchmark environment.
# Source this from /Users/shuqingzhao/github/verilog-eval-verilog before running
# generation/evaluation scripts.

export VERILOGEVAL_LANE=verilog
export VERILOGEVAL_ROOT=/Users/shuqingzhao/github/verilog-eval-verilog

# Use the upstream VerilogEval simulator path for pass/fail accounting.
# Verilator is intentionally avoided for this benchmark because some
# VerilogEval testbenches have race-sensitive stimulus.
export VERILOGEVAL_SIM=icarus
export IVERILOG=${IVERILOG:-iverilog}
export VVP=${VVP:-vvp}
