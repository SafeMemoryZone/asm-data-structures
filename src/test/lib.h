#pragma once

void *_malloc(unsigned long long length);
void _free(void *ptr, unsigned long long length);
void _memcpy(void *dest, void *src, unsigned long long length);