#include <stdio.h>
#include <getopt.h>

#include "proj.h"

static void usage (const char *name)
{
	char usage_string[] = 
"Usage: %s\n"
" -h,--help  print this message\n"
;
	printf(usage_string, name);
}

static int parse_args (int argc, char **argv)
{
	int opt;
	if (argc == 1) {
		printf("No arguments, try -h,--help\n");
		return EXIT_BAD_ARGS;
	}

	for (;;) {
		static struct option long_options[] = {
			{"help",         no_argument,       0, 'h'},
			{ 0,             0,                 0,  0 }
		};
		opt = getopt_long(argc, argv, "h", long_options, NULL);

		if (opt == -1)
			break;

		switch (opt) {
			case 'h':
				usage(argv[0]);
				return EXIT_SUCCESS;
				break;
			default:
				return EXIT_BAD_ARGS;
		}
	}

	/* non-option arg parsing */
	if (optind < argc) {
		printf("non-option arguments: ");
		while (optind < argc)
			printf("%s ", argv[optind++]);
		printf("\n");
	}

	return EXIT_SUCCESS;
}

int main (int argc, char ** argv)
{
	int ret;

	if ((ret = parse_args(argc, argv)) != EXIT_SUCCESS)
		return ret;

	/* do program */

	return EXIT_SUCCESS;
}
