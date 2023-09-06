# ETIN20 workflow
We utilize the open souce toolchain from f4pga.

If writing Verilog or SystemVerilog you can simply use the included examples.
https://github.com/chipsalliance/f4pga-examples/tree/main/xc7/counter_test

VHDL is not explicitly supported by f4pga but here is a quick workaround, ymmv.

# run f4pga container

first do docker pull from the gcr.io link
docker pull gcr.io/hdl-containers/conda/f4pga/xc7/a100t:latest

```docker
docker run -i --platform linux/amd64 --hostname=xxxxxxxxxx 
--env=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
--env=PREFIX=/usr/local --volume=/Users/$user/FPGA:/mnt 
--runtime=runc -d gcr.io/hdl-containers/conda/f4pga/xc7/a100t:latest
```

## run yosys-ghdl container

first do docker pull hdlc/ghdl:yosys

```docker
docker run -i --platform linux/amd64 --hostname=xxxxxxxxxx 
--env=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
--env=CC=clang --env=CXX=clang++ 
--volume=/Users/$user//FPGA:/mnt --runtime=runc 
-d hdlc/ghdl:yosys
```

Now ~/FPGA is a shared directory

Take the vhdl code and convert it to verilog through ghdl --synth
see https://cadhut.com/2022/08/14/converting-vhdl-to-verilog/

`ghdl -a code.vhd`
`ghdl synth --out=verilog adder > code.v`

for vhdl 2008 use 
`ghdl -a --std=08 code.vhd`
etc

then run the f4pga toolchain

f4pga toolchain demands that the top module in the hdl file is declared as 
`module top (...`
see https://f4pga-examples.readthedocs.io/en/latest/personal-designs.html

then flash the bitstream file from the ~/FPGA folder using OpenFPGALoader that you installed from homebrew or w/e.
