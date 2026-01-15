#!/usr/bin/env python3

import argparse
import csv
import glob
import json



def main(args):

    clean_core_distances_glob = f"{args.pipeline_outdir}/**/*clean.core.distances.csv"
    clean_core_distances_files = glob.glob(clean_core_distances_glob, recursive=True)
    clean_core_distances_file_exists = len(clean_core_distances_files) > 0

    tests = [
        {
            "test_name": "clean_core_distances_file_exists",
            "test_passed": clean_core_distances_file_exists
        },
    ]

    output_fields = [
        "test_name",
        "test_result"
    ]

    output_path = args.output
    with open(output_path, 'w') as f:
        writer = csv.DictWriter(f, fieldnames=output_fields, extrasaction='ignore')
        writer.writeheader()
        for test in tests:
            if test["test_passed"]:
                test["test_result"] = "PASS"
            else:
                test["test_result"] = "FAIL"
            writer.writerow(test)

    for test in tests:
        if not test['test_passed']:
            exit(1)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Check outputs')
    parser.add_argument('--pipeline-outdir', type=str, help='Path to the pipeline output directory')
    parser.add_argument('-o', '--output', type=str, help='Path to the output file')
    args = parser.parse_args()
    main(args)
