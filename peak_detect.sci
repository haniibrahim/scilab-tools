function peaks=peak_detect(signal,threshold)
    // Detect the peaks of a signal
    //
    // Syntax
    // peak_detect(signal)
    // peak_detect(signal,threshold)
    //
    // Parameters
    // signal:  1:n or n:1 matrix of doubles, signal
    // threshold: double scalar, threshold 
    //
    // Description
    // For an input vector "signal", the function returns 
    // the position (indices) of the peaks of "signal".
    //
    // The ouput "peaks" is a row vector (size = number of peaks),
    // "peaks" =[] if no peak is found.
    //
    // Optional argument "threshold" eliminates the peaks under
    // the threshold value (noise floor).
    // 
    // <note>Clipped peaks (more than 2 samples of the signal at the same value)
    // are not detected. </note>
    //
    // Examples
    // signal=[   
    // 0.001963   0.0019845   0.0020898   0.0018879   0.0022874   0.0018302   0.0017081 ..
    // 0.0013136   0.0016488   0.0122558   0.0046076   0.00425   0.0044321   0.0054563 ..
    // 0.0064661   0.008572   0.013993   0.0370093   0.0496205   0.0142739   0.0085398 ..
    // 0.0058809   0.0043365   0.0035494   0.002418   0.0017854   0.0022249   0.004634 ..
    // 0.0027623   0.0019751 ..
    // ]
    // threshold = 0.005;                        // Set threshold (optional)
    // [r N] = size(signal);                     // Size of the signal vector
    // fscale = 22050 * (1:N)/N                  // frequency scale
    // 
    // peaks = peak_detect(signal, threshold);   // peak detection (peak indices of signal)
    // 
    // // Plotting
    // clf();                                    // Clear plot
    // w = gca();                                // graphic handles
    // plot2d(fscale,signal);                    // plot signal
    // plot2d(fscale, ones(1,N) * threshold);    // plot threshold
    // plot2d(fscale(peaks), signal(peaks), -3); // plot peaks
    // pl1=w.children(1); pl1.children.mark_foreground = 5; // peaks in red
    // pl2=w.children(2); pl2.children.line_style = 3;      // threshold line dashed
    // key=legend(["Signal"; "Threshold"; "Peaks"]);        // key
    // mprintf("Frequency peaks:")               // print peaks
    // disp(fscale(peaks));
    // 
    // See also
    // freson
    //
    // Authors
    // Jean-Luc Goudier 
    // Hani Ibrahim ; hani.ibrahim@gmx.de
    
[lhs,rhs] = argn();
apifun_checkrhs("peak_detect",rhs,1:2);             // Check if RHS is min. 1 , max. 2
apifun_checktype("peak_detect",signal,"signal",1,"constant"); // Check if signal contains doubles
apifun_checkvector ("peak_detect",signal,"signal",1);       // Check if signal is a vector
// if no threshold is committed threshold is the minimum of signal
if rhs==2 then 
    ts=threshold;
    apifun_checktype("peak_detect",threshold,"threshold",2,"constant"); // Check if threshold is a doubles
    apifun_checkscalar("peak_detect",threshold,"threshold",2); // Check if threshold is a scalar
elseif rhs==1 then 
    ts=min(signal);
end;

// signal has to be a row vector otherwise it will be converted
[r, c]=size(signal);
if r>1 then
    signal = signal'
    [r, c] = size(signal)   
    rvec_flag = %F // row vector flag
else
    rvec_flag = %T
end;

Lg=c-1; 
d_s=diff(signal); 
dd_s=[d_s(1),d_s(1,:)];               // diff first shift
d_s=[d_s(1,:),d_s(Lg)];               // diff size correction
ddd_s=[dd_s(1),dd_s(1,1:Lg)];         // diff second shift
Z=d_s.*dd_s;                          // diff zeros

peaks=find(((Z<0 & d_s<0)|(Z==0 & d_s<0 & ddd_s>0)) & signal>ts);

// if input vector was a column vector the output peaks vector will be converted
// to a column vector, too. Otherwise it stays as a row vector
if rvec_flag == %F then
    peaks = peaks'
end

endfunction


