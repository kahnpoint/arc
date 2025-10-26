import tiktoken
import argparse

def tokenize_text(text, model_name="gpt-4o-mini"):
    encoding = tiktoken.encoding_for_model(model_name)
    tokens = encoding.encode(text)
    return tokens

def detokenize_text(tokens, model_name="gpt-4o-mini"):
    encoding = tiktoken.encoding_for_model(model_name)
    text = encoding.decode(tokens)
    return text


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("filename", type=str)
    args = parser.parse_args()
    filename = args.filename
    with open(filename, "r") as f:
        text = f.read()
    tokens = tokenize_text(text)
    print(f"{len(tokens)} tokens")