get_deepseek_key <- function(filename = "DEEPSEEK_KEY") {
  scan(filename, what = "character", sep = NULL)
}

get_portkey_key <- function(filename = "PORTKEY_KEY") {
  scan(filename, what = "character", sep = NULL)
}

get_system_prompt <- function(text = "you are a Clinical data scientist expert") {
  return(text)
}

#' Get an `ellmer` chat API with given platform
#'
#' @param platform Platform provider
#' @param base_url Base url
#' @param api_key API key
#' @param model Model of choice
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
    chat <- ellmer::chat_portkey(
      system_prompt = get_system_prompt(),
      base_url = base_url,
      api_key = api_key,
      model = model
    )
  } else if (platform == "ollama") {
    chat <- ellmer::chat_ollama(
      system_prompt = get_system_prompt(),
      base_url = base_url,
      model = model
    )
  }

  return(chat)
}

#' Read prompt list from yaml file
#'
#' @param filename File name
#'
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
  ret <- paste(
    "As a Clinical data scientist expert, here is a",
    tlg@main_title, ":\n\n"
  )
  ret <- gsub("\\{table_text\\}", export_as_txt(tlg), base_prompt)
  ret
}

#' Update footnote with AI response
#'
#' @param outputs Output objects
#' @param prompt_list List of prompt
#' @param platform Platform provider
#' @param base_url Base url
#' @param api_key API key
#' @param model Model of choice
#'
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
      base_prompt <- prompt_list[[output_name]]$prompt
      current_prompt <- integrate_prompt(base_prompt, output@tbl)
      raw_response <- chat$chat(current_prompt)
      clean_response <- sub(".*?</think>\\s*", "", raw_response)
      output@footnotes <- c(output@footnotes, clean_response)
    }
    output
  })
  names(ret) <- names_outputs
  ret
}
