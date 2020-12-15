clc
clear all
close all

tic

Ninputs = 17;
Nbit = 33;
max_items_L(1) = 2;
bitWidth = Nbit+((Ninputs-1)*2);

i = 1;
type_tree = string(input('Choose DADDA or WALLACE: ','s'));

while max_items_L(end) < Ninputs
        max_items_L(i+1) = floor((3/2)*max_items_L(i));
        i = i + 1;
end

Nlevels = numel(max_items_L);

if type_tree == "DADDA"
       
elseif type_tree == "WALLACE"
    max_items_L = zeros(1,Nlevels);
end



levels_tensor_items = zeros(Ninputs,bitWidth,Nlevels);


for i=1:Ninputs
    if (i ~= Ninputs)
        for j = 1:Nbit
            PP_matrix_items(i,j) = 1;
            tmps = sprintf('PP(%d)(%d)',i-1,Nbit-j);
            PP_matrix_labels{i,j} = tmps;
        end
    else
        for j = 2:Nbit
            PP_matrix_items(i,j) = 1;
            tmps = sprintf('PP(%d)(%d)',i-1,Nbit-j);
            PP_matrix_labels{i,j} = tmps;
        end
        PP_matrix_items(i,1) = 0;
        tmps = "";
        PP_matrix_labels{i,1} = tmps;
    end
end

Ninputs_extended = 30;
    for i= 1:bitWidth
    filler_labels{i} = "";
end
filler_items = zeros(1,bitWidth);

for i = 1:Ninputs_extended
   
    switch i
        case 1
            signExt_head_items = [1 1 1];
            tmps1 = string(sprintf('PP(%d)(35)',i-1));
            tmps2 = string(sprintf('PP(%d)(34)',i-1));
            tmps3 = string(sprintf('PP(%d)(33)',i-1));
            signExt_head_labels = [tmps1 tmps2 tmps3];

            PP_ext_items = [signExt_head_items,PP_matrix_items(i,:)];
            PP_ext_labels = [signExt_head_labels,PP_matrix_labels{i,:}];

            zero_fill_first_items = zeros(1,bitWidth-numel(PP_ext_items));
            clear zero_fill_first_labels
            for s = 1:bitWidth-numel(PP_ext_items)
                zero_fill_first_labels{s} = "";
            end

            PP_ext_items = [zero_fill_first_items,PP_ext_items];
            PP_ext_labels = [zero_fill_first_labels,PP_ext_labels];   

% ---------------------------------------------------------------------------------------
        case Ninputs-1
            signExt_head_items = [1];
            tmps1 = string(sprintf('PP(%d)(33)',i-1));
            signExt_head_labels = [tmps1];

            shift_tail_items = zeros(1,2*(i-1));
            clear shift_tail_labels
            for k = 1:2*(i-1)
                shift_tail_labels{k} = "";
            end

            shift_tail_items(2*(i-1)-1) = 1;
            shift_tail_labels{2*(i-1)-1} = string(sprintf('PP_sign(%d)',i-2));
            
            PP_ext_items = [signExt_head_items,PP_matrix_items(i,:),flip(shift_tail_items)];
            PP_ext_labels = [signExt_head_labels,PP_matrix_labels{i,:},flip(shift_tail_labels)];

            zero_fill_first_items = zeros(1,bitWidth-numel(PP_ext_items));
            clear zero_fill_first_labels
            for s = 1:bitWidth-numel(PP_ext_items)
                zero_fill_first_labels{s} = "";
            end

            PP_ext_items = [zero_fill_first_items,PP_ext_items];
            PP_ext_labels = [zero_fill_first_labels,PP_ext_labels];  

% ---------------------------------------------------------------------------------------            
        case Ninputs
            
            shift_tail_items = zeros(1,2*(i-1));
            clear shift_tail_labels
            for k = 1:2*(i-1)
                shift_tail_labels{k} = "";
            end

            shift_tail_items(2*(i-1)-1) = 1;
            shift_tail_labels{2*(i-1)-1} = string(sprintf('PP_sign(%d)',i-2));
            
            PP_ext_items = [PP_matrix_items(i,:),flip(shift_tail_items)];
            PP_ext_labels = [PP_matrix_labels{i,:},flip(shift_tail_labels)];

% ---------------------------------------------------------------------------------------            
        otherwise
            
            if (i>Ninputs)
                PP_ext_items = filler_items;
                PP_ext_labels = filler_labels;
            else
            
                signExt_head_items = [1 1];
                tmps1 = string(sprintf('PP(%d)(33)',i-1));
                tmps2 = string(sprintf('PP(%d)(34)',i-1));
                signExt_head_labels = [tmps2,tmps1];

                shift_tail_items = zeros(1,2*(i-1));
                clear shift_tail_labels
                for k = 1:2*(i-1)
                    shift_tail_labels{k} = "";
                end

                shift_tail_items(2*(i-1)-1) = 1;
                shift_tail_labels{2*(i-1)-1} = string(sprintf('PP_sign(%d)',i-2));

                PP_ext_items = [signExt_head_items,PP_matrix_items(i,:),flip(shift_tail_items)];
                PP_ext_labels = [signExt_head_labels,PP_matrix_labels{i,:},flip(shift_tail_labels)];

                zero_fill_first_items = zeros(1,bitWidth-numel(PP_ext_items));
                clear zero_fill_first_labels
                for s = 1:bitWidth-numel(PP_ext_items)
                    zero_fill_first_labels{s} = "";
                end

                PP_ext_items = [zero_fill_first_items,PP_ext_items];
                PP_ext_labels = [zero_fill_first_labels,PP_ext_labels]; 
            end
            
            
% ---------------------------------------------------------------------------------------   
    end
    
    levels_tensor_items(i,2:66,Nlevels) = PP_ext_items;
    levels_tensor_labels(i,2:66,Nlevels) = PP_ext_labels;
                
end


figure()
spy(levels_tensor_items(:,:,7))

clc
close all

filename = "CSA_Tree.vhd";
fID = fopen(filename,'w');


fprintf(fID,'library ieee;\n');
fprintf(fID,'\tuse ieee.std_logic_1164.all;\n');
fprintf(fID,'\tuse ieee.numeric_std.all;\n');
fprintf(fID,'\t--use work.array_std.all;\n\n');


fprintf(fID,'entity CSA_Tree is\n');
fprintf(fID,'\tgeneric(N : integer := 33; N_PP : integer := 17);\n');
fprintf(fID,'\tport(\n');
fprintf(fID,'\t\tPP1      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP2      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP3      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP4      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP5      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP6      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP7      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP8      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP9      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP10      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP11      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP12      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP13      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP14      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP15      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP16      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP17      : in  std_logic_vector (N-1 downto 0);\n');
fprintf(fID,'\t\tPP_sign : in  std_logic_vector (N / 2 downto 0);\n');
fprintf(fID,'\t\tSUM     : out std_logic_vector (2 * N - 2 downto 0)\n\t);\n');
fprintf(fID,'end entity CSA_Tree;\n\n');

fprintf(fID,'architecture Dadda of CSA_Tree is\n\n');

fprintf(fID,'---- COMPONENTS DECLARATION ----\n');
fprintf(fID,'component HA is\n');
fprintf(fID,'\tport(\n');
fprintf(fID,'\t\tA, B : IN STD_LOGIC;\n');
fprintf(fID,'\t\tS, Co : OUT STD_LOGIC\n');
fprintf(fID,'\t);\n');
fprintf(fID,'end component HA;\n\n');


fprintf(fID,'component FA is\n');
fprintf(fID,'\tport(\n');
fprintf(fID,'\t\tA, B , Cin : IN STD_LOGIC;\n');
fprintf(fID,'\t\tS, Co : OUT STD_LOGIC\n');
fprintf(fID,'\t);\n');
fprintf(fID,'end component FA;\n\n');


fprintf(fID,'---- SIGNAL DECLARATION ----\n');
fprintf(fID,'type signal_matrix is array (29 downto 0) of std_logic_vector (64 downto 0);\n');
fprintf(fID,'type final_matrix is array (1 downto 0) of std_logic_vector (65 downto 0);\n');
for i = 1:Nlevels
    fprintf(fID,'signal SUM_RES_L%d : signal_matrix;\n',i);
    fprintf(fID,'signal CARRY_RES_L%d : signal_matrix;\n',i);
end
fprintf(fID,'signal PP : signal_matrix;\n',i);
fprintf(fID,'signal FINAL_SUM : final_matrix;\n\n');
fprintf(fID,'signal VDD, GND : std_logic;\n');

fprintf(fID,'begin\n\n');

fprintf(fID,'VDD <= ''1'';\n');
fprintf(fID,'GND <= ''0'';\n');

for i = 1:Ninputs
    switch i
        case 1
            fprintf(fID,'PP(%d)(35 downto 0) <= not(PP_sign(%d)) & PP_sign(%d) & PP_sign(%d) & PP%d;\n',i-1,i-1,i-1,i-1,i);
            
        case Ninputs-1
            fprintf(fID,'PP(%d)(33 downto 0) <= not(PP_sign(%d)) & PP%d;\n',i-1,i-1,i);
            
        case Ninputs
            fprintf(fID,'PP(%d)(32 downto 0) <= PP%d;\n',i-1,i);
            
        otherwise
            fprintf(fID,'PP(%d)(34 downto 0) <= VDD & not(PP_sign(%d)) & PP%d;\n',i-1,i-1,i);    
    end
end

fprintf(fID,'\n');



FA_count = 0;
HA_count = 0;
% for l = 7:-1:2 
%     fprintf('---------------------- LEVEL %d -------------------------------\n',l)
%     
%     for k = 1:Ninputs_extended
%                 tmp_col.val(k) = levels_tensor_items(k,65,l);
%                 tmp_col.state(k) = "unused";
%                 tmp_col.name(k) = levels_tensor_labels(k,65,l);
%     end
%     
%     for b = (bitWidth+1):-1:1
%         fprintf('B:%d\n',bitWidth-b-1)
%         
%         for k = 1:Ninputs_extended             
%                 tmp_col_next.val(k) = levels_tensor_items(k,b,l);
%                 tmp_col_next.state(k) = "unused";
%                 tmp_col_next.name(k) = levels_tensor_labels(k,b,l);
%         end
%             
%         excess_bits_tmp = sum(tmp_col.val) - max_items_L(l-1);
%         
%         if (excess_bits_tmp > 0)
%                           
%         % start compression of excess bits
%         
%             while (excess_bits_tmp > 0) % the column has to be reduced
%                 
%                 %disp('here');
%                 
%                 num_FA = floor(excess_bits_tmp/2);
%                 
%                 if (num_FA > 0) % a compressors can be instantiated
%                     excess_bits_tmp = excess_bits_tmp - 2;
%                     triplet_items = [];
%                     triplet_labels = [];
%                     triplet_idx = [];
%                     for i = 1:Ninputs_extended
%                         if (tmp_col.val(i) == 1 && tmp_col.state(i) == "unused")
%                             triplet_idx = [triplet_idx i];
%                             triplet_items = [triplet_items tmp_col.val(i)];
%                             triplet_labels = [triplet_labels tmp_col.name(i)];
%                             if (sum(triplet_items) == 3)
%                                                                 
%                                 FA_count = FA_count + 1;
%                                 fprintf('\tFA%d_L%d : (%s,%s,%s)\n',FA_count,l,tmp_col.name(triplet_idx(1)),tmp_col.name(triplet_idx(2)),tmp_col.name(triplet_idx(2)))
%                                 sum_name = string(sprintf('SUM(%s+%s+%s)',tmp_col.name(triplet_idx(1)),tmp_col.name(triplet_idx(2)),tmp_col.name(triplet_idx(3))));
%                                 carry_name = string(sprintf('CARRY(%s+%s+%s)',tmp_col.name(triplet_idx(1)),tmp_col.name(triplet_idx(2)),tmp_col.name(triplet_idx(3))));
%                                 
%                                 tmp_col.state(triplet_idx(3)) = "used";
%                                 tmp_col.state(triplet_idx(2)) = "used";
%                                 tmp_col.state(triplet_idx(1)) = "used";
%                                 tmp_col.val(triplet_idx(3)) = 1;
%                                 tmp_col.val(triplet_idx(2)) = 0;
%                                 tmp_col.val(triplet_idx(1)) = 0;
%                                 tmp_col.name(triplet_idx(3)) = sum_name;
%                                 tmp_col.name(triplet_idx(2)) = "";
%                                 tmp_col.name(triplet_idx(1)) = "";
%                                 idx = find(tmp_col_next.val == 0,1);
%                                 tmp_col_next.val(idx) = 1;
%                                 tmp_col_next.state(idx) = "used";
%                                 tmp_col_next.name(idx) = carry_name;
%                                 
%                                 break 
%                             end
%                         end  
%                     end
%                 else
%                     % an HA has to be instantiated
%                     excess_bits_tmp = excess_bits_tmp - 1;
%                     duplet_items = [];
%                     duplet_labels = [];
%                     duplet_idx = [];
%                     for i = 1:Ninputs_extended
%                         if (tmp_col.val(i) == 1 && tmp_col.state(i) == "unused")
%                             duplet_idx = [duplet_idx i];
%                             duplet_items = [duplet_items tmp_col.val(i)];
%                             duplet_labels = [duplet_labels tmp_col.name(i)];
%                             if (sum(duplet_items) == 2)
%                                                                 
%                                 FA_count = FA_count + 1;
%                                 fprintf('\tHA%d_L%d : (%s,%s)\n',FA_count,l,tmp_col.name(duplet_idx(1)),tmp_col.name(duplet_idx(2)));
%                                 sum_name = string(sprintf('SUM(%s+%s)',tmp_col.name(duplet_idx(1)),tmp_col.name(duplet_idx(2))));
%                                 carry_name = string(sprintf('CARRY(%s+%s)',tmp_col.name(duplet_idx(1)),tmp_col.name(duplet_idx(2))));
%                                 
%                                 tmp_col.state(duplet_idx(2)) = "used";
%                                 tmp_col.state(duplet_idx(1)) = "used";
%                                 tmp_col.val(duplet_idx(2)) = 1;
%                                 tmp_col.val(duplet_idx(1)) = 0;
%                                 tmp_col.name(duplet_idx(2)) = sum_name;
%                                 tmp_col.name(duplet_idx(1)) = "";
%                                 idx = find(tmp_col_next.val == 0,1);
%                                 tmp_col_next.val(idx) = 1;
%                                 tmp_col_next.state(idx) = "used";
%                                 tmp_col_next.name(idx) = carry_name;
%                                 
%                                 break 
%                             end
%                         end 
%                     end                
%                 end
%                 
%                 excess_bits_tmp = sum(tmp_col.val) - max_items_L(l-1);
%                 
%             end
%         
%         else
%             fprintf('\n')
%     end
%                     
%         levels_tensor_items(:,b+1,l-1) = tmp_col.val;
%         levels_tensor_labels(:,b+1,l-1) = tmp_col.name;
%             
%         tmp_col = tmp_col_next;
%     end
%     
%     figure()
%     spy(levels_tensor_items(:,:,l-1));
% 
% end

close all
clc
figure()
spy(levels_tensor_items(:,:,Nlevels));

FA_count = 0;
HA_count = 0;
for l = Nlevels:-1:2 
    fprintf(fID,'---------------------- LEVEL %d -------------------------------\n',l)
    
    for k = 1:Ninputs_extended
                tmp_col.val(k) = levels_tensor_items(k,66,l);
                tmp_col.state(k) = "unused";
                tmp_col.name(k) = levels_tensor_labels(k,66,l);
    end
    
    for b = (bitWidth):-1:1
        fprintf(fID,'--B:%d\n',bitWidth-b)
        
        for k = 1:Ninputs_extended             
                tmp_col_next.val(k) = levels_tensor_items(k,b,l);
                tmp_col_next.state(k) = "unused";
                tmp_col_next.name(k) = levels_tensor_labels(k,b,l);
        end
            
        excess_bits_tmp = sum(tmp_col.val) - max_items_L(l-1);
        
        if (excess_bits_tmp > 0)
                          
        % start compression of excess bits
        
            while (excess_bits_tmp > 0) % the column has to be reduced
                
                %disp('here');
                
                num_FA = floor(excess_bits_tmp/2);
                
                if (num_FA > 0) % a compressors can be instantiated
                    excess_bits_tmp = excess_bits_tmp - 2;
                    triplet_items = [];
                    triplet_labels = [];
                    triplet_idx = [];
                    for i = 1:Ninputs_extended
                        if (tmp_col.val(i) == 1 && tmp_col.state(i) == "unused")
                            triplet_idx = [triplet_idx i];
                            triplet_items = [triplet_items tmp_col.val(i)];
                            triplet_labels = [triplet_labels tmp_col.name(i)];
                            if (sum(triplet_items) == 3)
                                                                
                                FA_count = FA_count + 1;
                                sum_name = string(sprintf('SUM_RES_L%d(%d)(%d)',l,triplet_idx(3),bitWidth-b-1));
                                carry_name = string(sprintf('CARRY_RES_L%d(%d)(%d)',l,triplet_idx(3),bitWidth-b-1));
                                
                                fprintf(fID,'\tFA%d_L%d : FA port map (%s,%s,%s,%s,%s);\n',FA_count,l,tmp_col.name(triplet_idx(1)),tmp_col.name(triplet_idx(2)),tmp_col.name(triplet_idx(3)),sum_name,carry_name)
                               
                                tmp_col.state(triplet_idx(3)) = "used";
                                tmp_col.state(triplet_idx(2)) = "used";
                                tmp_col.state(triplet_idx(1)) = "used";
                                tmp_col.val(triplet_idx(3)) = 1;
                                tmp_col.val(triplet_idx(2)) = 0;
                                tmp_col.val(triplet_idx(1)) = 0;
                                tmp_col.name(triplet_idx(3)) = sum_name;
                                tmp_col.name(triplet_idx(2)) = "";
                                tmp_col.name(triplet_idx(1)) = "";
                                idx = find(tmp_col_next.val == 0,1);
                                tmp_col_next.val(idx) = 1;
                                tmp_col_next.state(idx) = "used";
                                tmp_col_next.name(idx) = carry_name;
                                
                                break 
                            end
                        end  
                    end
                else
                    % an HA has to be instantiated
                    excess_bits_tmp = excess_bits_tmp - 1;
                    duplet_items = [];
                    duplet_labels = [];
                    duplet_idx = [];
                    for i = 1:Ninputs_extended
                        if (tmp_col.val(i) == 1 && tmp_col.state(i) == "unused")
                            duplet_idx = [duplet_idx i];
                            duplet_items = [duplet_items tmp_col.val(i)];
                            duplet_labels = [duplet_labels tmp_col.name(i)];
                            if (sum(duplet_items) == 2)
                                                                
                                HA_count = HA_count + 1;
                                sum_name = string(sprintf('SUM_RES_L%d(%d)(%d)',l,duplet_idx(2),bitWidth-b-1));
                                carry_name = string(sprintf('CARRY_RES_L%d(%d)(%d)',l,duplet_idx(2),bitWidth-b-1));
                                
                                fprintf(fID,'\tHA%d_L%d : HA port map (%s,%s,%s,%s);\n',HA_count,l,tmp_col.name(duplet_idx(1)),tmp_col.name(duplet_idx(2)),sum_name,carry_name)
                               
                                tmp_col.state(duplet_idx(2)) = "used";
                                tmp_col.state(duplet_idx(1)) = "used";
                                tmp_col.val(duplet_idx(2)) = 1;
                                tmp_col.val(duplet_idx(1)) = 0;
                                tmp_col.name(duplet_idx(2)) = sum_name;
                                tmp_col.name(duplet_idx(1)) = "";
                                idx = find(tmp_col_next.val == 0,1);
                                tmp_col_next.val(idx) = 1;
                                tmp_col_next.state(idx) = "used";
                                tmp_col_next.name(idx) = carry_name;
                                
                                break 
                            end
                        end 
                    end                
                end
                
                
                excess_bits_tmp = sum(tmp_col.val) - max_items_L(l-1);
                
            end
        
        else
            fprintf(fID,'\n');
    end
                    
        levels_tensor_items(:,b+1,l-1) = tmp_col.val;
        levels_tensor_labels(:,b+1,l-1) = tmp_col.name;
        
        if (b+1 == 67) 
            disp('AhIA\n');
        end
            
        tmp_col = tmp_col_next;
    end
    
     figure()
     spy(levels_tensor_items(:,:,l-1));

end

%close all;

final_sum_vect.val = zeros(2,65);
for i = bitWidth:-1:1
    for j = 1:Ninputs_extended
        final_sum_vect.val(j,i) = 0;
        final_sum_vect.name(j,i) = "";
    end
end
        
fprintf(fID,'\n------ FINAL SUM -------------\n\n');

for i = bitWidth+1:-1:1
    count_el = 0;
    for j = 1:Ninputs_extended
        if levels_tensor_items(j,i,1) == 1
            count_el = count_el + 1;
            final_sum_vect.val(count_el,i) = levels_tensor_items(j,i,1);
            final_sum_vect.name(count_el,i) = levels_tensor_labels(j,i,1);
            
            fprintf(fID,'FINAL_SUM(%d)(%d) <= %s; --[%d]\n',count_el-1,bitWidth+1-i,final_sum_vect.name(count_el,i),i);
        end
    end
    if count_el < 2 && i > 1
        count_el = count_el + 1;
        final_sum_vect.val(count_el,i) = 1;
        final_sum_vect.name(count_el,i) = "GND";
        fprintf(fID,'FINAL_SUM(%d)(%d) <= %s; --[%d]\n',count_el-1,bitWidth+1-i,final_sum_vect.name(count_el,i),i);
    end
end

figure()
spy(final_sum_vect.val);

fprintf(fID,'\nfinal_sum_process : process (FINAL_SUM)\n');
fprintf(fID,'begin\n');
fprintf(fID,'\tSUM <= std_logic_vector(signed(FINAL_SUM(0)(64 downto 0)) + signed(FINAL_SUM(1)(64 downto 0)));\n');
fprintf(fID,'end process;\n');
fprintf(fID,'\nend architecture Dadda;');

fclose(fID);


           
