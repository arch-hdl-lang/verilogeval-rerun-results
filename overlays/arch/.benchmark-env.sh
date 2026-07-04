# ARCH-lane VerilogEval benchmark environment.
# Source this from /Users/shuqingzhao/github/verilog-eval-arch before running
# generation/evaluation scripts.

export VERILOGEVAL_LANE=arch
export VERILOGEVAL_ROOT=/Users/shuqingzhao/github/verilog-eval-arch
export ARCH_RELEASE_ROOT=/Users/shuqingzhao/github/arch-release-tools/v0.70.5
export ARCH_BIN=/Users/shuqingzhao/github/arch-release-tools/v0.70.5/bin/arch
export ARCH_MCP_NAME=arch-hdl-release-v0705
export ARCH_MCP_WORKSPACE_ROOTS=/Users/shuqingzhao/github/verilog-eval-arch

# Use the upstream VerilogEval simulator path for pass/fail accounting.
# Verilator is intentionally avoided for this benchmark because some
# VerilogEval testbenches have race-sensitive stimulus.
export VERILOGEVAL_SIM=icarus
export IVERILOG=${IVERILOG:-iverilog}
export VVP=${VVP:-vvp}
