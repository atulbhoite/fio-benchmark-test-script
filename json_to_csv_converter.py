import json
import logging.config
import re

log = logging.getLogger(__name__)
log.setLevel(level=logging.DEBUG)
logging.config.fileConfig('./config/logging.conf', disable_existing_loggers=False)


def convert_json_to_csv():
    # read the file with ordered filenames
    fname = open("ordered_filenames.txt", "r")
    ordered_filenames = fname.readlines()
    fname.close()
    log.debug("Ordered filenames: %s", ordered_filenames)

    csvfile = open("../fio_results/fio_benchmarks.csv", "a")
    csvrowheader = ", ".join(
        ["block-size", "size", "number of threads", "random/sequential", "read/write percentage", "read_bw",
         "read_iops", "read_lat", "write_bw", "write_iops", "write_lat"]) + '\n'
    csvfile.write(csvrowheader)

    for filename in ordered_filenames:
        log.debug("filename: %s", filename)

        # try to get the individual file details from the filename for output text files
        pattern = "(\d{1,6}\D\D)_(.{1,6})_(.{1,6})_(.{1,6})_(read|randread|randrw|randwrite|write)_output.txt$"

        with open(("../fio_results/" + filename).rstrip()) as data_file:
            data = json.load(data_file)

            if filename.__contains__("read") or filename.__contains__("randread"):
                groups = re.findall(pattern, filename)
                log.debug("groups: %s", groups)
                read_bw = str(data["jobs"][0]["read"]["bw"])
                read_iops = str(data["jobs"][0]["read"]["iops"])
                read_lat = str(data["jobs"][0]["read"]["clat"]["mean"])
                read_write_percent = str(100 - int(groups[0][3]))
                csvrow = ", ".join(
                    [groups[0][0], groups[0][1], groups[0][2], groups[0][4], groups[0][3] + "/" + read_write_percent, read_bw,
                     read_iops, read_lat]) + '\n'

            else:
                groups = re.findall(pattern, filename)
                log.debug("groups: %s", groups)
                read_bw = str(data["jobs"][0]["read"]["bw"])
                read_iops = str(data["jobs"][0]["read"]["iops"])
                read_lat = str(data["jobs"][0]["read"]["clat"]["mean"])
                write_bw = str(data["jobs"][0]["write"]["bw"])
                write_iops = str(data["jobs"][0]["write"]["iops"])
                write_lat = str(data["jobs"][0]["write"]["clat"]["mean"])
                read_write_percent = str(100 - int(groups[0][3]))
                csvrow = ", ".join(
                    [groups[0][0], groups[0][1], groups[0][2], groups[0][4], groups[0][3] + "/" + read_write_percent,
                     read_bw, read_iops, read_lat, write_bw, write_iops, write_lat]) + '\n'

            csvfile.write(csvrow)

        data_file.close()
    csvfile.close()


if __name__ == '__main__':
    convert_json_to_csv()
