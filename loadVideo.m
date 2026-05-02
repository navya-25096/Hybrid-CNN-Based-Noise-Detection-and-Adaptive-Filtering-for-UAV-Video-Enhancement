function frames = loadVideo(file)
v = VideoReader(file);
i=1;
while hasFrame(v)
    frames{i} = readFrame(v);
    i=i+1;
end
end
