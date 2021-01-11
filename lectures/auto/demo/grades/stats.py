#!/usr/bin/env python

import sys
import os
import csv
import unicodedata


class Group:
    def __init__(self, name):
        self.name = name
        self.final = 0
        self.quiz = 0
        self.practical = 0
        self.midterm = 0
        self.asgn = 0
        self.num = 0

    def add(self, final_grade, quiz_grade, practical_grade, midterm_grade, asgn_grade):
        self.final += final_grade
        self.quiz += quiz_grade
        self.practical += practical_grade
        self.midterm += midterm_grade
        self.asgn += asgn_grade
        self.num += 1

    def print(self):
        final_avg = float(self.final) / self.num
        quiz_avg = float(self.quiz) / self.num
        practical_avg = float(self.practical) / self.num
        midterm_avg = float(self.midterm) / self.num
        asgn_avg = float(self.asgn) / self.num
        print("{:12s}{:8d}{:8.2f}{:8.2f}{:8.2f}{:8.2f}{:8.2f}".format(self.name, self.num, final_avg, quiz_avg, asgn_avg, midterm_avg, practical_avg))


class Year:
    def __init__(self, fname):
        self.fname = fname
        self.name = fname[:-4]
        self.year = Group(self.name)
        self.series = {
                "CA": Group("CA"),
                "CB": Group("CB"),
                "CC": Group("CC"),
                "CD": Group("CD")
                }

    def parse(self):
        csvfile = open(self.fname, "rt")
        reader = csv.reader(csvfile, delimiter=',', quotechar='"')
        next(reader, None)  # Skip header.

        for row in reader:
            group = row[0]
            try:
                final = float(row[2])
                quiz = float(row[4])
                asgn = float(row[9])
                midterm = float(row[15])
                practical = float(row[16])
            except ValueError:
                continue

            self.year.add(final, quiz, practical, midterm, asgn)
            group_id = group[-2:]
            self.series[group_id].add(final, quiz, practical, midterm, asgn)

        csvfile.close()

    def print(self):
        self.year.print()
        for s in self.series.values():
            s.print()


targets = {
        "2016-2017": "2016-2017.csv",
        "2017-2018": "2017-2018.csv",
        "2018-2019": "2018-2019.csv",
        "2019-2020": "2019-2020.csv"
        }


def main():
    years = []
    for t in targets.values():
        y = Year(t)
        years.append(y)

    print("{:12s}{:>8s}{:>8s}{:>8s}{:>8s}{:>8s}{:>8s}".format("Grup", "Număr", "Notă", "Quiz", "Teme", "Midterm", "Practic"))
    for y in years:
        y.parse()
        y.print()
        print()


if __name__ == "__main__":
    sys.exit(main())
