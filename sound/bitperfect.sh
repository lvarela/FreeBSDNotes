sudo sysctl hw.snd.vpc_0db=60
sudo sysctl dev.pcm.2.bitperfect=1
sudo  sysctl hw.usb.uaudio.default_bits=16
sudo  sysctl hw.usb.uaudio.default_rate=44100
sudo sysctl hw.snd.default_unit=2
sudo sysctl dev.pcm.2.play.vchans=0
mixer vol 100:100
mixer pcm 100:100
xset b off
