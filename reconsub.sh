DOMAIN="$1"
OUTPUTDIR="$HOME/target/$DOMAIN"

echo "[-] Run..."
echo "[-] Creating output dir $OUTPUTDIR"
mkdir -p $OUTPUTDIR

#run amass
echo "[1] Recon amass"
amass enum -d $DOMAIN -o $OUTPUTDIR/$DOMAIN.amass

echo "[2] Recon findomain"
$HOME/tools/findomain -o -t $DOMAIN
mv $DOMAIN.txt $OUTPUTDIR/$DOMAIN.findomain

echo "[3] httprobe running "
cat $OUTPUTDIR/$DOMAIN* | sort -u | tee $OUTPUTDIR/$DOMAIN.all | httprobe -prefer-https | tee $OUTPUTDIR/$DOMAIN.httprobe

#echo "[4] Screenshoting "
#webscreenshot -i $OUTPUTDIR/$DOMAIN.httprobe -o $OUTPUTDIR/screenshot


echo "[-] Finish"
echo "[-] Output file $OUTPUTDIR/$DOMAIN"
