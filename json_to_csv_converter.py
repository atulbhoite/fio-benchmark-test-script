import json
import logging.config
import re

log = logging.getLogger(__name__)
log.setLevel(level=logging.DEBUG)
logging.config.fileConfig('../test/config/logging.conf', disable_existing_loggers=False)

def convert_json_to_csv():

    # read the file with ordered filenames
    fname = open("./ordered_testfilenames.txt", "r")
    ordered_filenames = fname.readlines()
    fname.close()
    log.debug("Ordered filenames: %s", ordered_filenames)

    csvfile = open("../fio_results/collatedresults.csv", "a")
    csvrowheader = ", ".join(["block-size", "size", "number of threads", "random/sequential", "read/write percentage", "read_bw", "read_iops", "read_lat", "write_bw", "write_iops", "write_lat"]) + '\n'
    csvfile.write(csvrowheader)

    for filename in ordered_filenames:
        log.debug ("filename: %s", filename)

        # try to get the individual file details from the filename for seq read files
        pattern = "(\d{1,})_(.{1,})_(.{1,})_(.{1,})_(.{1,})_(seqread|randread)_output.txt$"

        with open( ("../fio_results/" + filename).rstrip()) as data_file:
            data = json.load(data_file)

            if (filename.__contains__("seqread")):
                groups = re.findall(pattern, filename)
                log.debug("groups: %s", groups)
                read_bw = str(data["jobs"][0]["read"]["bw"])
                read_iops = str(data["jobs"][0]["read"]["iops"])
                read_lat = str(data["jobs"][0]["read"]["clat"]["mean"])
                csvrow = ", ".join(
                    [groups[0][0], groups[0][1], groups[0][2], groups[0][5], groups[0][3] + "/" + groups[0][4], read_bw,
                     read_iops, read_lat]) + '\n'

            if (filename.__contains__("randread")):
                read_bw = str(data["jobs"][0]["read"]["bw"])
                groups = re.findall(pattern, filename)
                log.debug("groups: %s", groups)
                read_iops = str(data["jobs"][0]["read"]["iops"])
                read_lat = str(data["jobs"][0]["read"]["clat"]["mean"])
                write_bw = str(data["jobs"][0]["write"]["bw"])
                write_iops = str(data["jobs"][0]["write"]["iops"])
                write_lat = str(data["jobs"][0]["write"]["clat"]["mean"])
                csvrow = ", ".join(
                    [groups[0][0], groups[0][1], groups[0][2], groups[0][5], groups[0][3] + "/" + groups[0][4],
                     read_bw, read_iops, read_lat, write_bw, write_iops, write_lat]) + '\n'

            csvfile.write(csvrow)

        data_file.close()
    csvfile.close()


if __name__ == '__main__':
    convert_json_to_csv()


