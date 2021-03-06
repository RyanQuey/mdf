function S = extractXmlHelper(obj,items)
    % S = loadXmlHelper(obj,items)
    %
    % take the dom item in input and builds the corresponding matlab structure
    %
    % arguments
    %   items = dom items from xml parser
    % output
    %   S = matlab structure with configuration subtree
    %
    
    % 
    % initialize output structure
    S = struct;
    % cycle through all the child nodes
    for i = 0:(items.getLength-1)
        % extract child
        child = items.item(i);
        % get child name
        name = strtrim(char(child.getNodeName));
        % get child text
        value = strtrim(char(child.getTextContent));
        % get node child nodes
        children = child.getChildNodes;
        % count child nodes
        nc = children.getLength;
        % get attributes for this item
        attributes = obj.getXmlAttributes(child);
        % decide if it is a text value
        text = strcmp(name,'#text');
        
        % check if it is a valid node or not
        % conditions:
        %  - name is different than #text and we have child nodes
        %  - name is equal to #text and value is not empty
        if ( ( ~text & nc > 0 ) | ...
                 ( text & ~isempty(value) ) )
            % we are in good shape,
            % we have a branch or a leaf
            if ( nc > 0 )
                
                % we have a branch
                % insert branch and descend in the dom tree
                value = obj.extractXmlHelper(children);
               
                % check if value is a string/char and pemdform allowed
                % operations on it
                if isa(value,'char')
                    % check if we have attributes that modify string value
                    
                    % relative_to attribute
                    % both values need to be strings and path
                    % the new value will be the value provided by relative_to
                    % prepended to current value
                    % also checks if we have a corresponding value to
                    % prepend
                    if ( isfield(attributes,'relative_path_to') && ...
                            ~isempty(attributes.relative_path_to) )
                        % make sure that relative_path_to does not have .
                        relative_path_to = regexprep(attributes.relative_path_to,'\.','__');
                        % now check if we have the token
                        if ( isfield(obj.temp.tokens,relative_path_to) && ...
                                ~isempty(obj.temp.tokens.(relative_path_to)) && ...
                                isa(obj.temp.tokens.(relative_path_to),'char') )
                            % concatenate relative path and current value
                            value = fullfile(obj.temp.tokens.(relative_path_to), value);
                        end %if
                    elseif ( isfield(attributes,'type')  && ...
                                ~isempty(attributes.type) && ...
                                strcmp(attributes.type,'numeric') )
                        % configuration dictate that this must be a numeric
                        % value
                        if ~isempty(str2num(value))
                            value = str2num(value);
                        end     
                    end
                    
                    % check if user has specified token
                    token_name = name;
                    if ( isfield(attributes,'token_name') && ...
                            ~isempty(attributes.token_name) )
                        % make sure that relative_path_to does not have .
                        token_name = attributes.token_name;
                    end %if
                    token_name = regexprep(token_name,'\.','__');
                    
                    % insert value in values for future substitutions
                    obj.temp.tokens.(token_name) = value;
                    
                    % give that is a string
                    % check if there is already another value in the
                    % structure, convert to array and uppend
                    if ( isfield(S,name) ) 
                        % field already exists
                        % check if is a string and needs to be converted to
                        % cell array
                        if ( isa(S.(name),'char') )
                            S.(name) = {S.(name)};
                        end
                        % append value at the end
                        S.(name){end+1} = value;
                    else
                        % new field
                        S.(name) = value;
                    end
                else
                    % the value is not a string
                    % insert value in structure
                    % over-write old values
                    S.(name) = value;
                end
                
                % check if we have attribute 'present_as'
                if ( isfield(attributes,'present_as') && ...
                    ~isempty(attributes.present_as) )
                    % initialize the 'present' value with the current value
                    pvalue = value;
                    % check if we have attribute 'present_sub' and if
                    % exists a sub item in the struct with that name
                    if ( isfield(attributes,'present_sub') && ...
                            ~isempty(attributes.present_sub) && ...
                             isfield(S.(name),attributes.present_sub) ) 
                        % this attribute allow to present a substitute the
                        % value of the current value with the value of a
                        % sub item.
                        % Useful when we deal with cell array of strings

                        % assign to pvalue the value of the sub item
                        pvalue = S.(name).(attributes.present_sub);
                    end
                    % check if we have attribute 'present_in'
                    if ( isfield(attributes,'present_in') && ...
                            ~isempty(attributes.present_in) )
                        % we do not want to rename the item here
                        % we insert it in R and pass it along
                        obj.temp.presents.(attributes.present_in).(attributes.present_as) = pvalue;
                    else
                        % we create another entry with key provided by the
                        % attribute 'present_as' and same value
                        S.(attributes.present_as) = pvalue;
                    end
                end
                
                % check if we have some 'present_as' to insert under this item
                % the value of this item needs to be a struct
                if ( isfield(obj.temp.presents,name) && ...
                        isa(value,'struct') ) 
                    % insert values
                    fields = fieldnames(obj.temp.presents.(name));
                    for ii = 1:length(fields)
                        S.(name).(fields{ii}) = obj.temp.presents.(name).(fields{ii});
                    end
                    % remove the values
                    rmfield(obj.temp.presents,(name));
                end
      
            else
                % we have a leaf
                % return value
                S = value;
            end
           
        end
       
    end
    
end

