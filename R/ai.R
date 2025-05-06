get_deepseek_key <- function(filename = "DEEPSEEK_KEY") {
  scan(filename, what = "character", sep = NULL)
}

get_portkey_key <- function(filename = "PORTKEY_KEY") {
  scan(filename, what = "character", sep = NULL)
}

get_system_prompt <- function(text = "you are a Clinical data scientist expert") {
  return(text)
}

#'
#' @export
#'
get_ellmer_chat <- function(platform = "deepseek",
                            base_url = "https://api.deepseek.com",
                            api_key = get_deepseek_key(),
                            model = "deepseek-chat") {
  chat <- NULL
  if (platform == "deepseek") {
    chat <- ellmer::chat_deepseek(
      system_prompt = get_system_prompt(),
      base_url = base_url,
      api_key = api_key,
      model = model
    )
  } else if (platform == "galileo") {
    chat <- chat_portkey(
      system_prompt = get_system_prompt(),
      base_url = base_url,
      api_key = api_key,
      model = model
    )
  }
  return(chat)
}

#' @export
get_prompt_list <- function(filename) {
  prompt <- yaml::read_yaml(filename, eval.expr = TRUE)
  structure(
    .Data = prompt,
    names = map_chr(prompt, `[[`, "output"),
    class = union("spec", class(prompt))
  )
}


integrate_prompt <- function(base_prompt, tlg) {
  # let's do figures in the future
  ret <- gsub("\\{table_text\\}", export_as_txt(tlg), base_prompt)
  ret
}

#' @export
adding_ai_footnotes <- function(outputs, prompt_list, platform, base_url, api_key, model) {
  chat <- get_ellmer_chat(platform, base_url, api_key, model)
  names_outputs <- names(outputs)
  ret <- lapply(names_outputs, function(output_name) {
    output <- outputs[[output_name]]
    if (is(output, "autoslider_error")) {
      return(output)
    }
    if (output_name %in% names(prompt_list)) {
      current_prompt <- integrate_prompt(prompt_list[[output_name]]$prompt, output@tbl)
      output@footnotes <- c(output@footnotes, chat$chat(current_prompt)) # gather_ai_feedback()
    }
    output
  })
  print(ret)
  names(ret) <- names_outputs
  return(ret)
}
