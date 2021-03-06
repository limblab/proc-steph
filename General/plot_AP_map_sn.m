%
% Plot action potential waveforms of Utah array recordings
%
%       The function takes an bdf_struct (generated from a BDF) as input.
%       Several bdf_structs can be merged into an array of structs. 
%       The function returns either a handle to the figure.
%
%       PLOT_AP_MAP( bdf_struct ): plots the mean +/- SD waveform. Channels
%           are ordered sequentially, not using an array map file
%       PLOT_AP_MAP( bdf_struct, plot_std ): bool 'plot_std' defines
%           whether the SD of the AP waveform will be plotted  
%       PLOT_AP_MAP( bdf_struct, array_map_file): 'array_map' is the path
%           to a Blacrock map file  
%       PLOT_AP_MAP( bdf_struct, ch_nbr ): 'ch_nbr' is an array that
%           defines the channels the user wants to plot. Use this to plot
%           only a subset of channels      
%       PLOT_AP_MAP( bdf_struct, array_map_file, plot_std ): 'array_map' is
%           the path to the map file provided by Blackrock. Bool 'plot_std'
%           defines whether the SD of the AP waveform will be plotted
%       PLOT_AP_MAP( bdf_struct, ch_nbr, plot_std ): 'ch_nbr' is an array
%           that defines the channels the user wants to plot. Bool
%           'plot_std' defines whether the SD of the AP waveform will be
%           plotted  
%       PLOT_AP_MAP( bdf_struct, array_map_file, plot_std, Vpp ):
%           'array_map' is the path to the map file provided by Blackrock.
%           Bool 'plot_std' defines whether the SD of the AP waveform will
%           be plotted. 'Vpp' is the peak-to-peak voltage (uV) --when not
%           specified, matlab will automatically adjust the scale of each
%           AP plot
%       PLOT_AP_MAP( bdf_struct, ch_nbr, plot_std, Vpp ): 'ch_nbr' is an
%           array that defines the channels that will be (orderly) plotted.
%           Bool 'plot_std' defines whether the SD of the AP waveform will
%           be plotted. 'Vpp' is the peak-to-peak voltage (uV) --when not
%           specified, matlab will automatically adjust the scale of each
%           AP plot
%
%
% Last edited by Juan Gallego - Dec 6, 2015
%


function varargout = plot_AP_map_sn( bdf_struct, varargin )

% get parameters
if nargin == 2
    if islogical(varargin{1})
        plot_std        = varargin{1};
    elseif isnumeric(varargin{1})
        ch_nbrs         = varargin{1};
    elseif ischar(varargin{1})
        array_map_file  = varargin{1};
    end
elseif nargin >= 3
    if isnumeric(varargin{1})
        ch_nbrs         = varargin{1};
    elseif ischar(varargin{1}) || iscell(varargin{1})
        array_map_file  = varargin{1};
    end
    plot_std            = varargin{2};
    if nargin == 4
        Vpp             = varargin{3};
    end
end

% set missing params to defaults
if ~exist('plot_std','var')
    plot_std            = true;
end

% -------------------------------------------------------------------------
% Create an array with the channels that will be plotted
if ~exist('ch_nbrs','var')
    ch_nbrs             = 1:length(bdf_struct(1).units);
end

% Define colors for each of the files
color_array             = ['k','r','b','g','m','c'];

% Read how many BDFs we want to plot
nbr_bdfs                = numel(bdf_struct);

% If an array_map file was passed, use it
if exist('array_map_file','var')
   if iscell(array_map_file)
       nbr_arr_map_files = numel(array_map_file);
   else
       nbr_arr_map_files = 1;
   end
   % if several map files have been passed, each of them will be assigned
   % to a different BDF. If not, the same will be used for all BDFs
   if nbr_arr_map_files > 1
       if nbr_arr_map_files ~= nbr_bdfs
           error('ERROR: The number of array_map files does not match the name of BDFs');
       end
       for i = 1:nbr_arr_map_files
          bdf_struct(i).map  = get_array_mapping(array_map_file{i});
       end
   else
       for i = 1:nbr_bdfs
          bdf_struct(i).map  = get_array_mapping(array_map_file);
       end
   end      
end

% -------------------------------------------------------------------------
% The plot itself

% Figure handle
AP_shapes_fig           = figure('units','normalized','outerposition',[0 0 1 1]);


for i = 1:nbr_bdfs
    % if no array_map file has been passed, the channels will be plotted in
    % order
    if ~exist('array_map_file','var')

        panel_ctr       = 2;

        for ii = 1:length(ch_nbrs)

            mean_AP     = mean(bdf_struct(i).units(ch_nbrs(ii)).waveforms);
            std_AP      = std(double(bdf_struct(i).units(ch_nbrs(ii)).waveforms));

            nbr_rc      = ceil(sqrt(length(ch_nbrs)));
            
            % Plot the mean (or mean +/- SD waveform), depending on the options
            subplot(nbr_rc,nbr_rc,panel_ctr-1);
            if plot_std
                hold on, plot(mean_AP,'color',color_array(i),'linewidth',1);
                plot(mean_AP+std_AP,'color',color_array(i),'linewidth',1,'linestyle','-.');
                plot(mean_AP-std_AP,'color',color_array(i),'linewidth',1,'linestyle','-.');
            else
                hold on, plot(mean_AP,'color',color_array(i),'linewidth',2);
            end
            title(['ch #' num2str(ch_nbrs(ii))])
            % Readjust the scale, if specified by the user
            if exist('Vpp','var'), ylim([-Vpp/2 Vpp/2]); end
            
            panel_ctr   = panel_ctr + 1;
            
%             % add labels
%             if ii == 1
%                 ylabel('ch 1');
%             elseif rem(ii-1,nbr_rc) == 0
%                 ylabel(['ch ' num2str(ii)])
%             end
%             if ii >= (nbr_rc*(nbr_rc-1)+1)
%                 xlabel(['ch ' num2str(ii)])
%             end
        end
    %----------------------------------------------------------------------    
    % if we passed an array file    
    else
        for ii = 1:length(ch_nbrs)
             
            mean_AP     = mean(bdf_struct(i).units(ii).waveforms);
            std_AP      = std(double(bdf_struct(i).units(ii).waveforms));
            
            [row, col]  = find( bdf_struct(i).map==ii );
            
            % Plot the mean (or mean +/- SD waveform), depending on the options
            subplot(10,10,col+(row-1)*10);
            if plot_std
                hold on, plot(mean_AP,'color',color_array(i),'linewidth',1);
                plot(mean_AP+std_AP,'color',color_array(i),'linewidth',1,'linestyle','-.');
                plot(mean_AP-std_AP,'color',color_array(i),'linewidth',1,'linestyle','-.');
            else
                hold on, plot(mean_AP,'color',color_array(i),'linewidth',2);
            end
            % Readjust the scale, if specified by the user
            if exist('Vpp','var'), ylim([-Vpp/2 Vpp/2]); end
        end
    end
end

% -------------------------------------------------------------------------
% return the handle
if nargout == 1

    varargout{1}        = AP_shapes_fig;
elseif nargout > 1
   
    error('ERROR: the function only takes 1 output argument');
end