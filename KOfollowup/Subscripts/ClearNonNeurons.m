
    function [out_struct]=ClearNonNeurons(out_struct)
        counter=1;
        for a=1:length(out_struct.units)
            if out_struct.units(a).id(2)==0;
                Rows2cut(counter)=a;
                counter=counter+1;
            end
        end
        out_struct.units(Rows2cut)=[];
    end
