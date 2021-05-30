# Merging audio and video file

We pass both files as input through the '-i' flag
And the output name is 'directly mentioned' after the command.

And for options to pass, we should pass "-c:a copy" and "-c:v copy", where "-c" is used to pass the codec, here it's audio(a) and video(v), and we are asking both to be copied to the output

