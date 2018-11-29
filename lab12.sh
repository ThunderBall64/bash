#! /usr/bin/awk -f

#string format printf "%-55s %s\n"


BEGIN {
        print "Access Log Summary"

        print "====================\n\n"

}

{
        entries[$1]+=1

        if ($9 > 400)
                errors[$9]+=1

        if ($9 > 400)
                errEn[$1]+=1

        if ($9 == 401)
                unaut[$1]+=1
}

END {
        print "TOTAL NUMBER OF ENTRIES: " NR
        print "\n============================================================================="

        printf "%s %55s %10s\n", "Client", "Connections", "Errors"

        print "=============================================================================\n"

        for(x in entries)
                printf "%-55s %s %10s\n", x, entries[x], errEn[x]

        print "=============================================================================\n"


        print "\n============================================================================="
        print "Error Summary"
        for (y in errors)
                printf "\t%5s %s\n", y ": ", errors[y]
        print "=============================================================================\n"


        print "\n============================================================================="
        for (z in unaut)
                if (unaut[z] > 80)
                        printf "%s %s %s\n", "***** ALERT: " unaut[z], "Unauthorized attempts from", z
        print "=============================================================================\n"
}


        print "====================\n\n"

}

