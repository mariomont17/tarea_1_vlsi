import subprocess
import csv
import os

def generate_spice_deck(directory, filename, parameters):
    # Create directory if it doesn't exist
    if not os.path.exists(directory):
        os.makedirs(directory)

    filepath = os.path.join(directory, filename)

    # Customize this function to create your HSPICE deck
    # Example: write parameters to the SPICE file
    with open(filepath, 'w') as file:
        file.write(f"* fo4_{parameters['P1']}.sp\n")
        file.write(f"****************************************************************\n")
        file.write(f"* Parameters and models\n")
        file.write(f"****************************************************************\n")
        file.write(f".param SUPPLY=1.8\n")
        file.write(f".temp {parameters['temp']}\n")
        file.write(f".param H={parameters['H']}\n")
        file.write(f".lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src/Hspice/lp5mos/xt018.lib' tm\n")
        file.write(f".lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src/Hspice/lp5mos/param.lib' 3s\n")
        file.write(f".lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src/Hspice/lp5mos/config.lib' default\n")
        file.write(f"****************************************************************\n")
        file.write(f"\n")
        file.write(f".global vdd gnd\n")
        file.write(f"\n")
        file.write(f"****************************************************************\n")
        file.write(f"* Subcircuits\n")
        file.write(f"****************************************************************\n")
        file.write(f".subckt inv a y N={parameters['N1']} P={parameters['P1']}\n")
        file.write(f"xm0 y a gnd gnd ne w='N' l=180n as=-1 ad=-1 ps=-1 pd=-1\n")
        file.write(f"+ nrs=-1 nrd=-1 m='1*1' par1='1*1' xf_subext=0\n")
        file.write(f"xm1 y a vdd vdd pe w='P' l=180n as=-1 ad=-1 ps=-1\n")
        file.write(f"+ pd=-1 nrs=-1 nrd=-1 m='1*1' par1='1*1' xf_subext=0\n")
        file.write(f".ends\n")
        file.write(f"***************************************************************\n")
        file.write(f"* Simulation Netlist\n")
        file.write(f"***************************************************************\n")
        file.write(f"v1 vdd gnd dc='SUPPLY'\n")
        file.write(f"v2 a gnd dc=0 pulse ( 0 'SUPPLY' 0p 100p 100p 1n 2n )\n")
        file.write(f"X1 a b inv                      * shape input waveform\n")
        file.write(f"X2 b c inv M='H'                * reshape input waveform\n")
        file.write(f"X3 c d inv M='H**2'             * device under test\n")
        file.write(f"X4 d e inv M='H**3'             * load\n")
        file.write(f"X5 e f inv M='H**4'             * load on load\n")
        file.write(f"**************************************************************\n")
        file.write(f"* Stimulus\n")
        file.write(f"**************************************************************\n")
        file.write(f".tran 0.01p 2n start=0\n")
        file.write(f".measure tpdr * rising prop delay\n")
        file.write(f"+ TRIG v(c) VAL='SUPPLY/2' FALL=1\n")
        file.write(f"+ TARG v(d) VAL='SUPPLY/2' RISE=1\n")
        file.write(f".measure tpdf * falling prop delay\n")
        file.write(f"+ TRIG v(c) VAL='SUPPLY/2' RISE=1\n")
        file.write(f"+ TARG v(d) VAL='SUPPLY/2' FALL=1\n")
        file.write(f".measure tpd param='(tpdr+tpdf)/2' * average prop delay\n")
        file.write(f".measure trise * rise time\n")
        file.write(f"+ TRIG v(d) VAL='0.2*SUPPLY' RISE=1\n")
        file.write(f"+ TARG v(d) VAL='0.8*SUPPLY' RISE=1\n")
        file.write(f".measure tfall * fall time\n")
        file.write(f"+ TRIG v(d) VAL='0.8*SUPPLY' FALL=1\n")
        file.write(f"+ TARG v(d) VAL='0.2*SUPPLY' FALL=1\n")
        file.write(f".measure diff param='tpdr-tpdf' * diff between delays\n")
        file.write(f".option opfile=1 split_dp=1\n")
        file.write(f".option post=1\n")
        file.write(f".option runlvl = 5\n")
        file.write(f".end\n")

    return filepath

def run_simulation(spice_file):
    # Customize this line based on your HSPICE executable and file paths
    command = f"hspice {spice_file}"

    # Run the simulation using subprocess
    subprocess.run(command, shell=True)

def post_process_mt0_file(mt0_file):
    # Customize this function based on your .mt0 file format
    with open(mt0_file, 'r') as file:
        lines = file.readlines()

    # Find the line index containing the data
    last_values_index = len(lines) - 1

    # Extract the last two lines
    last_values_lines = lines[last_values_index - 1:last_values_index + 1]

    # Extract parameter values
    result_dict = [float(value) for value in " ".join(last_values_lines).split()]

    return result_dict

def save_to_csv(filename, headers, ratio, data):
    # If the file doesn't exist, write the header first
    if not os.path.exists(filename):
        with open(filename, 'w', newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(['Ratio'] + headers)

    # Write the values for each iteration
    with open(csv_filename, 'a', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow([ratio] + data)

if __name__ == "__main__":
    # Set simulation parameters
    simulation_params = {
        'N1': 220e-9,
        'P1': 440e-9,
        'temp': 25,
        'H':4,
    }

    # Set the directory to store HSPICE decks
    spice_directory = "hspice_decks_fo4"

    # Set the CSV filename
    csv_filename = "delays.csv"
    headers = ['tpdr', 'tpdf', 'tpd', 'trise', 'tfall', 'diff']
    #pmos_nmos_ratios = [1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0] 
    pmos_nmos_ratios = [round(r * 0.1, 1) for r in range(10, 41)]
    nmos_width = 220e-9

    for i, pmos_ratio in enumerate(pmos_nmos_ratios):
        
        simulation_params['N1'] = nmos_width
        simulation_params['P1'] = nmos_width*pmos_ratio
        ratio_int_part = int(pmos_ratio)
        ratio_frac_part = int((pmos_ratio % 1) * 100) 
        # Generate HSPICE deck
        spice_file = generate_spice_deck(spice_directory, f"fo4_{ratio_int_part}_{ratio_frac_part}.sp", simulation_params)

        # Run simulation
        run_simulation(spice_file)

        # Post-process .mto file
        mt0_file = f"fo4_{ratio_int_part}_{ratio_frac_part}.mt0"
        extracted_params = post_process_mt0_file(mt0_file)

        # Save extracted parameters to CSV
        save_to_csv(csv_filename, headers, pmos_ratio, extracted_params)

    print(f"Delays simulations saved to {csv_filename}")
