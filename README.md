<div align="center">

<h1>vLLM Endpoint | Serverless Worker </h1>

[![CI | Test Worker](https://github.com/runpod-workers/worker-template/actions/workflows/CI-test_worker.yml/badge.svg)](https://github.com/runpod-workers/worker-template/actions/workflows/CI-test_worker.yml)
&nbsp;
[![Docker Image](https://github.com/runpod-workers/worker-template/actions/workflows/CD-docker_dev.yml/badge.svg)](https://github.com/runpod-workers/worker-template/actions/workflows/CD-docker_dev.yml)

🚀 | This serverless worker utilizes vLLM (very Large Language Model) behind the scenes and is integrated into RunPod's serverless environment. It supports dynamic auto-scaling using the built-in RunPod autoscaling feature.
</div>

## Setting up the Serverless Worker

### Option 1: Pre-Built Image


### Option 2: Build Image with Model Inside
#### Docker Arguments:
- `MODEL_NAME`: the Hugging Face model to use.
- `MODEL_BASE_PATH`: directory to store the model in
- `HUGGING_FACE_HUB_TOKEN`: Your Hugging Face token to access private or gated models. You can get your token [here](https://huggingface.co/settings/token).
- `QUANTIZATION`: `awq` to use AWQ Quantization (Base model must be in AWQ format). `squeezellm` for SqueezeLLM quantization - preliminary support.
### Environment Variables:

### Compatible Models
- LLaMA & LLaMA-2 
- Mistral 
- Yi
- ChatGLM
- Phi
- MPT 
- OPT 
- Qwen 
- Aquila & Aquila2 
- Baichuan
- BLOOM 
- Falcon 
- GPT-2
- GPT BigCode
- GPT-J
- GPT-NeoX
- InternLM

> [!IMPORTANT]
> If you are using private models or ones that are gated, such as Llama 2, you must provide your Hugging Face token as a docker argument. 


### Examples
#### llama2 2.7B Chat:
```bash
docker build . --platform linux/amd64 --build-arg --build-arg MODEL_NAME=meta-llama/Llama-2-7b-chat-hf --build-arg STREAMING=True  HUGGING_FACE_HUB_TOKEN=your_hugging_face_token_here
```
#### 


Ensure that you have Docker installed and properly set up before running the docker build commands. Once built, you can deploy this serverless worker in your desired environment with confidence that it will automatically scale based on demand. For further inquiries or assistance, feel free to contact our support team.


## Model Inputs
```
| Argument           | Type            | Default   | Description                                                                                                                                                      |
|--------------------|-----------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| n                  | int             | 1         | Number of output sequences to return for the given prompt.                                                                                                      |
| best_of            | Optional[int]   | None      | Number of output sequences that are generated from the prompt. From these `best_of` sequences, the top `n` sequences are returned. `best_of` must be greater than or equal to `n`. This is treated as the beam width when `use_beam_search` is True. By default, `best_of` is set to `n`. |
| presence_penalty   | float           | 0.0       | Float that penalizes new tokens based on whether they appear in the generated text so far. Values > 0 encourage the model to use new tokens, while values < 0 encourage the model to repeat tokens.                        |
| frequency_penalty  | float           | 0.0       | Float that penalizes new tokens based on their frequency in the generated text so far. Values > 0 encourage the model to use new tokens, while values < 0 encourage the model to repeat tokens.                          |
| temperature        | float           | 1.0       | Float that controls the randomness of the sampling. Lower values make the model more deterministic, while higher values make the model more random. Zero means greedy sampling.                                        |
| top_p              | float           | 1.0       | Float that controls the cumulative probability of the top tokens to consider. Must be in (0, 1]. Set to 1 to consider all tokens.                            |
| top_k              | int             | -1        | Integer that controls the number of top tokens to consider. Set to -1 to consider all tokens.                                                               |
| use_beam_search    | bool            | False     | Whether to use beam search instead of sampling.                                                                                                             |
| stop               | Union[None, str, List[str]] | None | List of strings that stop the generation when they are generated. The returned output will not contain the stop strings.                       |
| ignore_eos         | bool            | False     | Whether to ignore the EOS token and continue generating tokens after the EOS token is generated.                                                            |
| max_tokens         | int             | 256       | Maximum number of tokens to generate per output sequence.                                                                                                   |
| logprobs           | Optional[int]   | None      | Number of log probabilities to return per output token.                                                                                                     |
```

## Test Inputs
The following inputs can be used for testing the model:
```json
{
    "input": {
       "prompt": "Who is the president of the United States?",
       "sampling_params": {
           "max_tokens": 100
       }
    }
}
```
