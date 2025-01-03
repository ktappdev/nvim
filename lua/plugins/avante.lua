return {
  {
    "yetone/avante.nvim",
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    build = "make",
    -- opts = {},
    opts = {
      provider = "openrouterDeepseek", -- available openrouterOpenAi also openai directly
      -- openai = {
      -- 	endpoint = "https://api.openai.com/v1",
      -- 	model = "gpt-4o",
      -- 	temperature = 0.1,
      -- 	max_tokens = 4096,
      -- 	["local"] = false,
      -- },
      -- claude = {
      -- 	endpoint = "https://api.anthropic.com",
      -- 	model = "claude-3-5-sonnet-20241022",
      -- 	api_key_name = "ANTHROPIC_API_KEY",
      -- 	temperature = 0.1,
      -- 	max_tokens = 4096,
      -- 	["local"] = false,
      -- },
      vendors = {
        --@type AvanteProvider
        openrouterGeminiexp = {
          endpoint = "https://openrouter.ai/api/v1/chat/completions",
          model = "google/gemini-pro-1.5",
          api_key_name = "OPENROUTER_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
                -- Optional headers for OpenRouter rankings
                ["HTTP-Referer"] = "localhost",
                ["X-Title"] = "nvim-avante",
              },
              body = {
                model = opts.model,
                messages = {
                  { role = "system", content = code_opts.system_prompt },
                  { role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
                },
                temperature = 0.5,
                max_tokens = 4096,
                stream = true,
              },
            }
          end,
          -- OpenRouter follows OpenAI's response format, so we can use the OpenAI parser
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").openai.parse_response(data_stream, event_state, opts)
          end,
        },
        openrouterClaude = {
          endpoint = "https://openrouter.ai/api/v1/chat/completions",
          model = "anthropic/claude-3.5-sonnet",
          api_key_name = "OPENROUTER_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
                -- Optional headers for OpenRouter rankings
                ["HTTP-Referer"] = "localhost",
                ["X-Title"] = "nvim-avante",
              },
              body = {
                model = opts.model,
                messages = {
                  { role = "system", content = code_opts.system_prompt },
                  { role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
                },
                temperature = 0.5,
                max_tokens = 4096,
                stream = true,
              },
            }
          end,
          -- OpenRouter follows OpenAI's response format, so we can use the OpenAI parser
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").openai.parse_response(data_stream, event_state, opts)
          end,
        },
        openrouterDeepseek = {
          endpoint = "https://openrouter.ai/api/v1/chat/completions",
          model = "deepseek/deepseek-chat", -- The model you want to use
          api_key_name = "OPENROUTER_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
                -- Optional headers for OpenRouter rankings
                ["HTTP-Referer"] = "localhost",
                ["X-Title"] = "nvim-avante",
              },
              body = {
                model = opts.model,
                messages = {
                  { role = "system", content = code_opts.system_prompt },
                  { role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
                },
                temperature = 0.5,
                max_tokens = 4096,
                stream = true,
              },
            }
          end,
          -- OpenRouter follows OpenAI's response format, so we can use the OpenAI parser
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").openai.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      {
        "grapp-dev/nui-components.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
