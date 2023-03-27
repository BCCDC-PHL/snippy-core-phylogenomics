#!/usr/bin/env python3

import argparse
import csv
import sys

def main(args):

    output_fieldnames = [
        'ID',
        'LENGTH',
        'ALIGNED',
        'UNALIGNED',
        'VARIANT',
        'HET',
        'MASKED',
        'LOWCOV',
        'PERCENT_USED',
    ]
    writer = csv.DictWriter(sys.stdout, fieldnames=output_fieldnames, dialect='excel-tab')
    writer.writeheader()
    
    with open(args.input, 'r') as f:
        reader = csv.DictReader(f, dialect='excel-tab')
        for row in reader:
            if int(row['LENGTH']) > 0:
                row['PERCENT_USED'] = round(100 * int(row['ALIGNED']) / int((row['LENGTH'])), 2)
            else:
                row['PERCENT_USED'] = 0.0

            writer.writerow(row)

    
    
    

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input')
    args = parser.parse_args()
    main(args)
