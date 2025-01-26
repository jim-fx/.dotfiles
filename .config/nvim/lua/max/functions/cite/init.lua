local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local function read_bib_files()
    -- loop through all .bib files
    local current_dir = vim.fn.getcwd()
    local bib_files = vim.fn.glob(current_dir .. "/*.bib", false, true)
    local entries = {}

    if #bib_files == 0 then
        print("No .bib files found in current directory.")
    else
        print("List of .bib files in current directory:")
        for _, file in ipairs(bib_files) do
            print(file)
            local content = io.open(file, "r")
            if content then
                local lines = content:read("*all")
                local parser = vim.treesitter.get_string_parser(lines, "bibtex")
                local tree = parser:parse()
                local root = tree[1]:root()

                -- Extracting reference name and title
                local references = {}
                for node in root:iter_children() do
                    if node:type() == "entry" then
                        local ref_name_node = node:child(0)
                        local title_node = node.child(node, 1)
                        if ref_name_node and title_node then
                            local ref_name = lines:sub(ref_name_node:start(), ref_name_node:end_()) -- Extract reference name
                            local title = lines:sub(title_node:start(), title_node:end_()) -- Extract title
                            table.insert(references, { ref_name = ref_name, title = title })
                        end
                    end
                end
                -- Printing reference name and title
                for _, ref in ipairs(references) do
                    print("Reference name: " .. ref.ref_name .. ", Title: " .. ref.title)
                end
            end
        end
    end
    return entries
end

local function cite()
    local entries = read_bib_files()
    --vim.notify(vim.inspect(entries))
end

-- init vim command :Cite
vim.api.nvim_create_user_command("Cite", cite, {})
