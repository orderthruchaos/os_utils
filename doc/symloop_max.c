/*
 * ==========================================================================
 *
 *       Filename:  symloop_max.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2014-07-01
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Brett DiFrischia
 *                  Brett.DiFrischia@thomsonreuters.com
 *        Company:  Thomson Reuters
 *
 * ==========================================================================
 */




#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <sys/param.h>




int main(void) {
    unsigned int symloop_max = 32;

#ifdef SYMLOOP_MAX
    symloop_max = SYMLOOP_MAX;
#elif defined(MAXSYMLINKS)
    symloop_max = MAXSYMLINKS;
#endif

    printf("%u\n", symloop_max);

    return 0;
}


