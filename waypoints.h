/*
 * debootstrap waypoints for run-debootstrap. See the README for docs.
 */
struct waypoint {
	int endpercent;
	char *progress_id;
};
static struct waypoint waypoints[] = {
	{ 0,    "START" },	/* dummy entry, required */
	{ 1,	"DOWNREL" },	/* downloading release files; very quick */
	{ 5,	"DOWNPKGS" },	/* downloading packages files; time varies
	                           by bandwidth (and size); low granularity */
	{ 10,	"SIZEDEBS" },   /* getting packages sizes; high granularity */
	{ 25,	"DOWNDEBS" },   /* downloading packages; run time varies by
				   bandwidth; high granularity */
	{ 45,	"EXTRACTPKGS" },/* extracting the core packages */
	{ 50,	"INSTCORE" },	/* installing packages needed for dpkg to
				   work */
	{ 60,	"UNPACKREQ" },	/* unpacking required packages */
	{ 70,	"CONFREQ" },	/* configuring required packages */
	{ 85,	"UNPACKBASE" },	/* unpacking the rest of the base system */
	{ 100,	"CONFBASE" },	/* configuring the rest of the base system */
	{ 0,	NULL },		/* last entry, required */
};
